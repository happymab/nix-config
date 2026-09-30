{ self, inputs, ... }: {
  flake.nixosModules.openWebUi = { pkgs, lib, ... }: {

    services.open-webui = {
      enable = true;

      # Optional: Set the port web UI
      port = 8080;

      environment = {
        # Disable telemetry and analytics
        ANONYMIZED_TELEMETRY = "False";
        DO_NOT_TRACK = "True";
        SCARF_NO_ANALYTICS = "True";
        # Set OpenAI base URL to port of Lemonade API server
        OPENAI_API_BASE_URL = "http://127.0.0.1:13305/v1";
        # Set OpenAI API key for Lemonade API server
        OPENAI_API_KEY = "lemonade";
        # Set Ollama base URL to port of Lemonade API server
        # OLLAMA_API_BASE_URL = "http://127.0.0.1:13305";
        # Disable authentication
        WEBUI_AUTH = "False";
      };
    };
  };
}
