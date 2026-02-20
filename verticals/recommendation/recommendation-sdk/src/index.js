export class Service {
  constructor() {
    this.name = 'recommendation-sdk';
    this.vertical = 'recommendation';
  }
  async execute(data) {
    return { success: true, service: this.name, data };
  }
}
export default Service;
