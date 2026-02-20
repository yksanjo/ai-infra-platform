export class Service {
  constructor() {
    this.name = 'anomaly-detection-api';
    this.vertical = 'anomaly-detection';
  }
  async execute(data) {
    return { success: true, service: this.name, data };
  }
}
export default Service;
