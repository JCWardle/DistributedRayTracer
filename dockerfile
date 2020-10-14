FROM elixir

COPY mix.exs .
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get

WORKDIR /app
