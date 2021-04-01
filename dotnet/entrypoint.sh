#!/usr/bin/env bash

export System__Scheduler__Start

case "$1" in
website)
  exec dotnet MARS.WebApp.dll
  ;;
scheduler)
  System__Scheduler__Start=true
  exec dotnet MARS.WebApp.dll
  ;;
esac
