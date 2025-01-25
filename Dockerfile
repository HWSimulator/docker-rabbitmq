FROM rabbitmq:4.0-management-alpine AS builder

RUN apk update; \
    apk add curl; \
    curl -L https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases/download/v4.0.2/rabbitmq_delayed_message_exchange-4.0.2.ez > $RABBITMQ_HOME/plugins/rabbitmq_delayed_message_exchange-4.0.2.ez;
    
FROM rabbitmq:4.0-management-alpine

COPY --from=builder $RABBITMQ_HOME/plugins/rabbitmq_delayed_message_exchange-4.0.2.ez $RABBITMQ_HOME/plugins/rabbitmq_delayed_message_exchange-4.0.2.ez
RUN apk update; \
    apk add curl; \
    curl -L https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases/download/v4.0.2/rabbitmq_delayed_message_exchange-4.0.2.ez > $RABBITMQ_HOME/plugins/rabbitmq_delayed_message_exchange-4.0.2.ez; \
    rabbitmq-plugins enable --offline rabbitmq_delayed_message_exchange rabbitmq_consistent_hash_exchange rabbitmq_prometheus rabbitmq_shovel rabbitmq_shovel_management
