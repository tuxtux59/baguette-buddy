import Config from 'react-native-config';
import ky from 'ky';
import { Receipe } from '../types/api';

const baseUrl = Config.REACT_APP_BACKEND_URL ?? 'http://localhost:3001';

const original = ky.create({
  prefixUrl: baseUrl,
  hooks: {
    // beforeRequest: [() => console.debug('before')],
    // afterResponse: [() => console.debug('after')],
  },
});

const api = original.extend((options) => ({
  prefixUrl: `${options.prefixUrl}/api`,
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  },
}));

const receipesApi = api.extend((options) => ({
  prefixUrl: `${options.prefixUrl}/receipes`,
}));

export const fetchReceipes = () => receipesApi.get<Receipe[]>('').json();
export const fetchReceipe = (id: string) => receipesApi.get<Receipe>(id).json();
export const deleteReceipe = (id: string) => receipesApi.delete(id).json();
