export class Service {
  constructor() {
    this.name = 'nlp-models';
    this.vertical = 'nlp';
  }
  async execute(data) {
    return { success: true, service: this.name, data };
  }
}
export default Service;
