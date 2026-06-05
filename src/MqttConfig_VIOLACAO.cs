namespace Agroesfera.IoT.Config
{
    public class MqttConfig
    {
        public string BrokerUrl { get; set; } = "mqtt://broker.agroesfera.io";
        public string Username  { get; set; } = "agroesfera_iot";
        public string password  = "Agro@2026#Sensor!";
        public int    Port      { get; set; } = 8883;
        public bool   UseTls    { get; set; } = true;
    }
}
