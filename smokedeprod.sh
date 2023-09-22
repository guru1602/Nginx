#!/bin/bash
#alb-nginx-frankfurtivfc-v2-167794839.eu-central-1.elb.amazonaws.com
. smoke.sh

smoke_url_prefix "alb-nginx-frankfurtivfc-266253467.eu-central-1.elb.amazonaws.com"

smoke_host "dealerplatform.de.ivendi.com"
smoke_url_ok "/de/api/stockmodule/health"
smoke_url_ok "/api/webshops/ping"
smoke_url_ok "/api/dealership-directory/ping"
smoke_url_ok "/uk/api/webshops/platform-plugin/ping"
smoke_url_ok "/uk/api/webshops/dealership-directory/ping"
smoke_url_ok "/v2/quoteware/ping"
smoke_url_ok "/platform/v2/ping"
smoke_url_ok "/dealer/platform/"
smoke_assert_body "iVendi Single Sign-On"

smoke_url_ok "/apps/webshops/main.js"
smoke_url_ok "/uk/apps/webshops/dealership-directory/main.js"
smoke_url_ok "/apps/dealership-directory/main.js"
smoke_url_ok "/uk/apps/webshops/platform-plugin/main.js"
remove_smoke_headers

smoke_host "webshops.de.newvehicle.com"
smoke_url_ok "/api/ping"
smoke_url_ok "/widgetapi/ping"
smoke_url_ok "/widget/i"
smoke_url_ok "/bootstrapper/i"
smoke_url_ok "/themebuilder/i"
remove_smoke_headers

smoke_host "de.newvehicle.com"
smoke_url_ok "/iam"
smoke_url_ok "/api/ping"
smoke_url_ok "/platform/v2/ping"

smoke_url_ok "/public-platform/v2/ping"
smoke_url_ok "/quoteware/ping"
smoke_url_ok "/api/theming/themes/api/ping"
remove_smoke_headers

smoke_host "webshops-admin.de.newvehicle.com"
smoke_url_ok "/platform/v2/ping"

smoke_url_ok "/api/webshops/ping"
smoke_url_ok "/api/dealership-directory/ping"
smoke_url_ok "/uk/api/webshops/platform-plugin/ping"
smoke_url_ok "/uk/api/webshops/dealership-directory/ping"
smoke_url_ok "/apps/webshops/main.js"
smoke_url_ok "/uk/apps/webshops/dealership-directory/main.js"
smoke_url_ok "/apps/dealership-directory/main.js"
smoke_url_ok "/uk/apps/webshops/platform-plugin/main.js"
remove_smoke_headers

smoke_host "my.de.newvehicle.com"
smoke_url_ok "/iam"
smoke_url_ok "/platform/v2/ping"
smoke_url_ok "/quoteware/ping"
smoke_url_ok "/api/ping"
smoke_url_ok "/api/theming/themes/api/ping"
smoke_url_ok "/api/webshops/ping"
smoke_url_ok "/api/dealership-directory/ping"
smoke_url_ok "/uk/api/webshops/platform-plugin/ping"
smoke_url_ok "/uk/api/webshops/dealership-directory/ping"
smoke_url_ok "/apps/webshops/main.js"
smoke_url_ok "/uk/apps/webshops/dealership-directory/main.js"
smoke_url_ok "/apps/dealership-directory/main.js"
smoke_url_ok "/uk/apps/webshops/platform-plugin/main.js"
remove_smoke_headers

smoke_host "qw3.de.ivendi.com"
smoke_url_ok "/ping"
smoke_url_ok "/adminapi/health"
remove_smoke_headers

smoke_host "paymentsearch.de.ivendi.com"
smoke_url_ok "/ping"
smoke_url_ok "/adminapi/health"
remove_smoke_headers

smoke_host "qwproxy.de.ivendi.com"
smoke_url_ok "/pingu"
remove_smoke_headers

smoke_host "qw-de.ivendi.com"
smoke_url_ok "/health/ready"
remove_smoke_headers

smoke_host "analytics.ivendi.com"
smoke_url_ok "/de/api/health"
remove_smoke_headers

smoke_host "dealer.ivendi.com"
smoke_url_ok "/de/"
remove_smoke_headers

smoke_host "lender.ivendi.com"
smoke_url_ok "/de/"
remove_smoke_headers

smoke_host "sso.ivendi.com"
smoke_url_ok "/"
smoke_assert_body "iVendi Single Sign-On"
remove_smoke_headers    

smoke_host "juhu.auto"
smoke_url_ok "/api/quoteware/health/live"
smoke_url_ok "/api/marketplace/health"
smoke_url_ok "/dealer-sitemap.xml"
smoke_url_ok "/gebrauchtwagen-sitemap.xml"
smoke_url_ok "/dataplane/ra.js"
smoke_url_ok "/dataplane"              #gives 404 but webpage gets dsiplayed
smoke_url_ok "/downloads/200504_Leadservice_CRM_Anleitung_final.pdf"

smoke_report