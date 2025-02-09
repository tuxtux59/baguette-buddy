import { fetchReceipe, fetchReceipes } from '../src/services/api';

test('should return the list of receipes', async () => {
  const res = await fetchReceipes();
  expect(res).toEqual([
    { id: '1', name: 'Tarte aux pommes', description: 'Cette recette est très bonne et facile à réaliser.' },
    { id: '2', name: 'Pizza Margherita', description: 'Cette pizza demande plus de dextérité et de préparation.' },
  ]);
});

test('should return receipe by it\'s id', async () => {
  const res = await fetchReceipe('1');
  expect(res).toEqual(
    { id: '1', name: 'Tarte aux pommes', description: 'Cette recette est très bonne et facile à réaliser.' },
  );

  const res2 = await fetchReceipe('2');
  expect(res2).toEqual(
    { id: '2', name: 'Pizza Margherita', description: 'Cette pizza demande plus de dextérité et de préparation.' },
  );
});

test('should return error when wrong id', async () => {
  await expect(fetchReceipe('-1')).rejects.toThrowError(/Request failed with status code 404 Not Found/);
});

