export class Service {
  constructor() {
    this.name = 'multimodal-sdk';
    this.vertical = 'multimodal';
  }
  async execute(data) {
    return { success: true, service: this.name, data };
  }
}
export default Service;
