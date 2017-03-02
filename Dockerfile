FROM fluent/fluentd:v0.12
ADD conf /fluentd/etc
RUN ["gem", "install", "fluent-plugin-elasticsearch", "--no-rdoc", "--no-ri", "--version", "1.9.2"]