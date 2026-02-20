export class Service {
  constructor() {
    this.name = 'forecasting-api';
    this.vertical = 'forecasting';
  }
  async execute(data) {
    return { success: true, service: this.name, data };
  }
}
export default Service;
