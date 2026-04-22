#!/bin/bash

BASE_URL="git@bitbucket.org:hnsdevops"
DIR="/home/vivekbhat/Projects/owaiops"

repos=(
  acu-stats-unzipper
  adg-stats-generator
  adg-terraform
  alarm-stream-processor-config
  alarm-stream-processor
  alarminator
  aspctl
  autoencoder-data-generator-terraform
  cfa-analysis
  cfa-pcn-report
  cfa-signature-manager
  cfa-unclassified-signatures-reporter
  contact-failure-analysis-terraform
  contact-stats-processor
  docker-builders
  fault-localization-service-terraform
  fault-notification-generator
  fault-stream-processor-config
  fault-stream-processor
  feature-vector-generator-config
  feature-vector-generator-old
  feature-vector-generator
  flink-state-test
  fls-axp-analysis
  fls-clustering-final
  go-aws
  go-emf
  go-kafka
  go-zipstreamprocessor
  ia-db-loaders
  ia-flink-state-test
  ia-scheduled-tasks
  ia-terraform-modules
  iactl
  invokelib
  java-checkstyle
  java-memory-utils
  java-metrics-handler
  java-snowflake
  kafkactl
  kpi-anomaly-detector
  owaiops_schemas
  owaiops_terraform
  pcn-db-loader
  pcn-downloader
  pcns_heatmap_figma
  pyavrotools
  pysnowflake
  qci-anomaly-detector
  sc-db-loader
  sem-analysis
  sem-db-loader
  sfloader
  sfn-db-loader
  sigman-db-loader
  sigman-report-processor
  snmp-trap-relay-config
  snmp-trap-relay
  snmp-trap-sender
  spa-data-analysis
  stats-stream-processor-config
  stats-stream-processor
  ut-stats-transformer
  ut-threshold-generator-config
  ut-threshold-generator
  weather-impact-analysis-terraform
  weatherwise
  win-db-loader
  win-processor
  zscaler-certificates-manager
)

for repo in "${repos[@]}"; do
  target="$DIR/$repo"
  if [ -d "$target/.git" ]; then
    echo "Updating $repo..."
    git -C "$target" checkout master 2>/dev/null || git -C "$target" checkout main
    git -C "$target" pull
  else
    echo "Cloning $repo..."
    git clone "$BASE_URL/$repo.git" "$target"
  fi
done
