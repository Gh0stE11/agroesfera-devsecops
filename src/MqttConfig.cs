namespace Agroesfera.IoT.Config
{
    public class MqttConfig
    {
        public string BrokerUrl { get; set; }
        public string Username  { get; set; }
        public string Password  { get; set; }
        public int    Port      { get; set; }
        public bool   UseTls    { get; set; }

        public static MqttConfig FromEnvironment()
        {
            return new MqttConfig
            {
                BrokerUrl = Environment.GetEnvironmentVariable("MQTT_BROKER_URL")
                            ?? throw new InvalidOperationException("MQTT_BROKER_URL nao configurado"),

                Username  = Environment.GetEnvironmentVariable("MQTT_USERNAME")
                            ?? throw new InvalidOperationException("MQTT_USERNAME nao configurado"),

                Password  = Environment.GetEnvironmentVariable("MQTT_PASSWORD")
                            ?? throw new InvalidOperationException("MQTT_PASSWORD nao configurado"),

                Port   = 8883,
                UseTls = true
            };
        }
    }
}
