import { Ingredient, Receipe } from '../types/api';

export const receipeBase64Img = (receipe: Receipe) => `data:${receipe.image_type};base64,${receipe.image}`;

export const receipeSmallDesc = (receipe: Receipe, maxChars = 200): string => {
  const words = receipe.description.split(' ');
  let result = '';
  for (let i = 0; i < Math.min(words.length, maxChars / 5); i++) {
    result += words[i] + ' ';
  }
  return result.trim() + '...';
};


export const properQuantity = (quantity: string): number => {
  return Number.isInteger(quantity) ? parseInt(quantity, 10) : parseFloat(quantity);
};

const factorizedValue = (quantity: string, portionsFactor = 1) => {
  const propQuantity = properQuantity(quantity);
  return portionsFactor * propQuantity;
};

export const ingredientProperQuantity = (ingredient: Ingredient, compact = false, factor = 1): string => {
  const q = factor !== 1 ? factorizedValue(ingredient.quantity, factor) : properQuantity(ingredient.quantity);
  const u = compact ? ingredient.unit.abbreviation : (q > 1 ? ingredient.unit.plural : ingredient.unit.name);

  return [q, u].join(' ');
};
