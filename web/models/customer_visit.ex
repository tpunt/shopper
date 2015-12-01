defmodule Shopper.CustomerVisit do
  import Ecto.Query

  def all(params) do
    case params do
      %{"fromDate" => fromDate, "toDate" => toDate} ->
        fromDate = fromDate
        toDate = toDate
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

    customer_visits = Shopper.Repo.all(
      from sv in Shopper.StoreVisit,
      join: c in Shopper.Customer,
      join: s in Shopper.Store,
        where: sv.visit_date >= ^fromDate,
        where: sv.visit_date <= ^toDate,
      select: %{longitude: c.longitude, latitude: c.latitude,
        post_code: c.post_code, store_id: s.store_id,
        distance_travelled: sv.distance_travelled}
    )
  end
end
