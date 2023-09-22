#!/bin/bash

. smoke.sh

smoke_url_prefix "https://alb-nginx-londonivfc-937481032.eu-west-2.elb.amazonaws.com"

smoke_host "ivendi.com"
smoke_url_ok "/iamivendi"
smoke_url_ok "/uk/api/webshops/platform-plugin/ping"
smoke_url_ok "/uk/api/webshops/dealership-directory/ping"
smoke_url_ok "/v2/quoteware/ping"
smoke_url_ok "/platform/v2/ping"
smoke_assert_body "iVendi Single Sign-On"

smoke_url_ok "/dealer/platform"
smoke_url_ok "/uk/api/stockmodule/health"
smoke_url_ok "/uk/api/webshops/dealership-directory/ping"
smoke_url_ok "/uk/api/webshops/platform-plugin/ping"
smoke_url_ok "/uk/api/webshops/enquiry-hub/ping"
smoke_url_ok "/platform/vnext/ping"
smoke_url_ok "/uk/apps/webshops/dealership-directory/main.js"
smoke_url_ok "/uk/apps/webshops/platform-plugin/main.js"
smoke_url_ok "/uk/apps/webshops/enquiry-hub/main.js"
remove_smoke_headers

smoke_host "newvehicle.com"
smoke_url_ok "/iam"
#smoke_url_ok "/platform/v1/internal/ping"
smoke_url_ok "/public-platform/v1/ping"
smoke_url_ok "/v2/quoteware/ping"
smoke_url_ok "/api/ping"
smoke_url_ok "/quoteware/ping"
smoke_url_ok "/api/reservenow-cache/001f6709-62d5-40bd-908a-4f019d6e3cc3-cf68fcn.json"
smoke_url_ok "/fass/index.html"
smoke_url_ok "/widgets/lib/index.html"
smoke_url_ok "/widgets/index.html"
remove_smoke_headers

smoke_host "webshops.newvehicle.com"
smoke_url_ok "/webshopsinternaladmin/index.html"
smoke_url_ok "/fpa-widget/index.html"
smoke_url_ok "/widget/index.html"
smoke_url_ok "/widget-demo/index.html"
smoke_url_ok "/bootstrapper/index.html"
smoke_url_ok "/webshopsacme/index.html"
smoke_url_ok "/widgetapi/ping"
smoke_url_ok "/themebuilder/index-theme-builder.html" #should give 403
smoke_url_ok "/api/ping"                              #should give 403
remove_smoke_headers

smoke_host "webshops-admin.newvehicle.com"  #all paths should give 403
smoke_url_ok "/index.html"
smoke_url_ok "/api/api/ping"
smoke_url_ok "/ddapi/api/ping"
smoke_url_ok "/platform/v1/internal/ping"
smoke_url_ok "/public-platform/v1/ping"
smoke_url_ok "/v2/quoteware/ping"
remove_smoke_headers

smoke_host "carwebproxy.ivendi.com"  #should give 403
smoke_url_ok "/"
remove_smoke_headers  

smoke_host "iv-backoffice.ivendi.com" #should give 403
smoke_url_ok "/api/ping"
remove_smoke_headers

smoke_host "my.newvehicle.com"
smoke_url_ok "/iam"
#smoke_url_ok "/platform/v1/internal/ping"
smoke_url_ok "/public-platform/v1/ping"
smoke_url_ok "/v2/quoteware/ping"
smoke_url_ok "/quoteware/ping"
smoke_url_ok "/api/ping"
remove_smoke_headers

smoke_host "qw3.ivendi.com"
smoke_url_ok "/ping"
smoke_url_ok "/iamquoteware"
remove_smoke_headers

smoke_host "lender.ivendi.com"
smoke_url_ok "/uk/"
remove_smoke_headers

smoke_host "aaf.webshops.newvehicle.com"
smoke_url_ok "/iam"
smoke_url_ok "/quoteware/ping"
smoke_url_ok "/widgets/Webshop"
remove_smoke_headers

smoke_host "acmemotors.co.uk/"
smoke_url_ok "/"
remove_smoke_headers

smoke_host "fafwidget.ivendi.com"
smoke_url_ok "/"
remove_smoke_headers

smoke_host "mn-demo.ivendi.com"
smoke_url_ok "/quoteware/ping"
smoke_url_ok "/v2/quoteware/pingu"
smoke_url_ok "/platform/vnext/"
smoke_url_ok "/platform/v"
remove_smoke_headers

smoke_host "faf-demo.ivendi.com"
smoke_url_ok "/quoteware/ping"
smoke_url_ok "/v2/quoteware/pingu"
remove_smoke_headers

smoke_report