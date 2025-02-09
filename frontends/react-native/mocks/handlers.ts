import { http, HttpResponse } from 'msw';
import { Receipe } from '../src/types/api';

const receipes = [
      { id: '1', name: 'Tarte aux pommes', description: 'Cette recette est très bonne et facile à réaliser.' },
      { id: '2', name: 'Pizza Margherita', description: 'Cette pizza demande plus de dextérité et de préparation.' },
];

export const handlers = [
  http.get('http://localhost:3001/api/receipes', () => {
    return HttpResponse.json(receipes);
  }),
  http.get('http://localhost:3001/api/receipes/:id', (info) => {
    const receipeId = info.params.id || -1;
    const receipe = receipes.find(r =>  r.id === receipeId);
    return receipe ? HttpResponse.json(receipe) : HttpResponse.json({error: 'not_found'}, {status: 404});
  }),
];
