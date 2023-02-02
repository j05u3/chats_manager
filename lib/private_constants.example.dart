/// maps each phone number id (from your whatsapp dashboard) to a name (assigned here by you)
const bot_phone_number_ids = <String, String>{
  "111111111111111": "bot1",
};

const api_bot_server_base_url = 'https://us-central1-my-project.cloudfunctions.net/endpoints_01';

const templates = <Map<String, String>>[
  {
    "id": "ck_recordatorio_01",
    "text": "Hola {{1}}. Eres {{2}}.",
  },
];
