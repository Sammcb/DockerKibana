$KB_HOME/bin/kibana-keystore create --allow-root
echo "$ADMIN_USER" | $KB_HOME/bin/kibana-keystore add --allow-root -f -x "elasticsearch.username"
echo "$ADMIN_PASSWORD" | $KB_HOME/bin/kibana-keystore add --allow-root -f -x "elasticsearch.password"
$KB_HOME/bin/kibana
