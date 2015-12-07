# Shopper

Contents:
 - [Overview](#overview)
 - [Introduction](#introduction)
 - [Application Features](#application-features)

## Overview

This application is the server application for mine and
[Liam Mann](https://github.com/liammann)'s **Shopper** application.

Shopper visualises the spatial distribution of a company’s stores and their
visiting customer base to provide further business intelligence for arbitrating
new store locations.

Link to client application: to be open sourced...

## Introduction

The aim of this project is to provide a generic solution that companies can
utilise to analyse the shopping location patterns of their customer base. This
is based on the requirement for companies to intelligently select new store
locations based on which areas will most likely yield the most revenue and
therefore increase their return on investment.

To achieve this, company store locations will be plotted on a map, along with
customer locations from the company’s sales history database. Lines will
visually represent the direct route from customer residence to store locations,
with a time lapse animation. These timeframes will either be over set periods
of time e.g. month by month, or from the opening of new stores in the area to
display fluctuations in customer store choices.

This will enable for the following facets to be inspected:
 - Where the general grouping of the customer base is
 - How far customers travel to their selected store
 - How successful a new store opening was
 - Which stores are being used less and whether there’s a correlation to the
 distance of the customer base. (This can then be used to indicate problems
   such as; questionable quality of the store, quantity of the products
   stocked, or other competitor’s stores in the area.)

## Application Features

The following features are provided by the client application:
 - Visualise spatial distribution of customers to the stores they visit
 - Get the mean and median distances customers travel to any given store
 - Customer visit history can be viewed from a given time scale, as well as
 from break points in the history according to new store openings
