defmodule Shopper.CustomerVisit do
  import Ecto.Query

  def all(params) do
    case params do
      %{"fromDate" => fromDate, "toDate" => toDate} ->
        fromDate = fromDate # date formatted properly?
        toDate = toDate # date formatted properly?
      %{"fromDate" => fromDate} ->
        fromDate = fromDate
        toDate = fromDate # to calculate properly
      %{"toDate" => toDate} ->
        toDate = toDate
        fromDate = toDate # to calculate properly
      _ ->
        {{year, month, day}, _} = :calendar.universal_time()
        toDate = to_string(:io_lib.format("~B-~2..0B-~2..0B", [year, month, day]))
        fromDate = to_string(:io_lib.format("~B-~2..0B-~2..0B", [year - 1, month, day]))
    end

    Shopper.Repo.all(
      from sv in Shopper.StoreVisit,
        where: sv.visit_date >= ^fromDate,
        where: sv.visit_date <= ^toDate,
      group_by: fragment("s0.customer_id, s0.store_id, s0.distance_travelled"),
      select: %{
        longitude: fragment("(SELECT longitude FROM customers WHERE customer_id = s0.customer_id) as longitude"),
        latitude: fragment("(SELECT latitude FROM customers WHERE customer_id = s0.customer_id) as latitude"),
        post_code: fragment("(SELECT post_code FROM customers WHERE customer_id = s0.customer_id) as post_code"),
        store_id: sv.store_id,
        distance_travelled: sv.distance_travelled,
        visit_count: fragment("COUNT(*)")
      }
    )
  end
end
