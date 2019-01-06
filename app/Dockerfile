FROM elixir:1.7.4

RUN mix local.hex --force
RUN mix local.rebar --force

COPY . /example
WORKDIR /example

RUN mix deps.get && mix deps.compile && mix compile

RUN chmod +x entrypoint.sh

EXPOSE 4000
