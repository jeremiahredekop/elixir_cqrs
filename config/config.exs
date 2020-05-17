use Mix.Config

config :bank_api, BankApi.Application,
  event_store: [
    adapter: Commanded.EventStore.Adapters.Extreme,
    serializer: Commanded.Serialization.JsonSerializer,
    stream_prefix: "elbanko",
    extreme: [
      db_type: :node,
      host: "localhost",
      port: 1113,
      username: "admin",
      password: "changeit",
      reconnect_delay: 2_000,
      max_attempts: :infinity
    ]
  ]
