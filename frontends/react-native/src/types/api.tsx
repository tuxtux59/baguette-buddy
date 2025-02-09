export type Unit = {
  name: string;
  plural: string;
  abbreviation: string;
}
export type Ingredient = {
  title: string;
  quantity: number;
  unit: Unit
}
export type Receipe = {
  id: string;
  title: string;
  description: string;
  portions_number: number;
  url: string;
  image: string;
  image_type: string;
  ingredients: Ingredient[];

};
