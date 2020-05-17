defmodule BankApi.Application do
  use Commanded.Application,
    otp_app: :bank_api,
    event_store: [adapter: Commanded.EventStore.Adapters.Extreme]

  router(BankRouter)
end
