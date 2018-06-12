#!/bin/bash
docker run -d --net=host --name text_vectorizer_$TS \
catenae/erdd-links text_vectorizer \
-i new_texts \
-o count_vectors \
-b localhost:9092 \
-a localhost:3000 \
-p aerospike:test:setup_objects

docker run -d --net=host --name vector_aggregator_$TS \
catenae/erdd-links vector_aggregator \
-i count_vectors \
-o aggregated_vectors \
-b localhost:9092 \
-a localhost:3000

docker run -d --net=host --name tfidf_transformer_$TS \
catenae/erdd-links tfidf_transformer \
-i count_vectors,aggregated_vectors \
-o tfidf_vectors \
-b localhost:9092 \
-a localhost:3000 \
-p aerospike:test:setup_objects

docker run -d --net=host --name model_predictor_$TS \
catenae/erdd-links model_predictor \
-i tfidf_vectors \
-o user_probabilities,text_probabilities,processed_users,processed_texts \
-b localhost:9092 \
-a localhost:3000 \
-p aerospike:test:setup_objects

docker run -d --net=host --name probability_storer_$TS \
catenae/erdd-links probability_storer \
-b localhost:9092 \
-i user_probabilities

docker run -d --net=host --name post_updater_$TS \
catenae/erdd-links post_updater \
-b localhost:9092 \
-i text_probabilities

docker run -d --net=host --name alert_manager_$TS \
catenae/erdd-links alert_manager \
-b localhost:9092 \
-a localhost:3000 \
-i user_probabilities \
-o alerts

docker run -d --net=host --name alert_storer_$TS \
catenae/erdd-links alert_storer \
-b localhost:9092 \
-i alerts
