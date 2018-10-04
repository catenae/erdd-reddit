#!/bin/bash
NUMBER=${2:-2}
CPUS=${1:-0-7}

for i in $(seq 1 $NUMBER); do
  for j in $(seq 1 2); do
    docker run -d --restart unless-stopped --net=host --name text_vectorizer_${TS}_${i}_${j} \
    --cpuset-cpus="$CPUS" \
    catenae/erdd-links text_vectorizer \
    -i new_texts \
    -o count_vectors \
    -b localhost:9092 \
    -a localhost:3000 \
    -p aerospike:test:setup_objects &
  done

  for j in $(seq 1 4); do
    docker run -d --restart unless-stopped --net=host --name tfidf_transformer_${TS}_${i}_${j} \
    --cpuset-cpus="$CPUS" \
    catenae/erdd-links tfidf_transformer \
    -i count_vectors,aggregated_vectors \
    -o tfidf_vectors \
    -b localhost:9092 \
    -a localhost:3000 \
    -p aerospike:test:setup_objects &
    docker run -d --restart unless-stopped --net=host --name vector_aggregator_${TS}_${i}_${j} \
    --cpuset-cpus="$CPUS" \
    catenae/erdd-links vector_aggregator \
    -i count_vectors \
    -o aggregated_vectors \
    -b localhost:9092 \
    -a localhost:3000 &
  done

  docker run -d --restart unless-stopped --net=host --name model_predictor_${TS}_${i}_${j} \
  --cpuset-cpus="$CPUS" \
  catenae/erdd-links model_predictor \
  -i tfidf_vectors \
  -o user_probabilities,text_probabilities,processed_users,processed_texts \
  -b localhost:9092 \
  -a localhost:3000 \
  -p aerospike:test:setup_objects &

done
wait
