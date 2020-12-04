FROM elixir

RUN mkdir -p /app
WORKDIR /app

COPY mix.exs .
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get

CMD ["mix", "run"]