FROM elasticsearch:7.9.3
#maintained by: abhishank@yahoo.com

# Magento 2 required plugins
# https://github.com/elastic/elasticsearch-analysis-icu
# https://github.com/elastic/elasticsearch-analysis-phonetic
RUN \
    elasticsearch-plugin install analysis-icu && \
    elasticsearch-plugin install analysis-phonetic