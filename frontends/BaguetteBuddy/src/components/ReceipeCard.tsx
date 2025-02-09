import React from 'react';
import { ReceipeCardProps } from '../types/props';
import { View } from 'react-native';
import { receipeBase64Img } from '../utils/receipes';
import { useNavigation } from '@react-navigation/native';
import { Colors } from 'react-native/Libraries/NewAppScreen';
import { Button, Card, Chip, TouchableRipple } from 'react-native-paper';

const ReceipeCard = ({ receipe }: ReceipeCardProps): React.JSX.Element => {
  const navigation = useNavigation();

  const goToDetails = () => navigation.navigate('show', { receipe: receipe })

  const leftContent = (props) => (
    <View {...props}>
      {receipe.ingredients.length > 0 && (
        <Chip
          icon="receipt"
          mode="outlined">
          {`${receipe.ingredients.length} ingr.`}
        </Chip>
      )}
    </View>
  );

  const handleDelete = async () => {
    // const resp = await deleteReceipe(receipe.id);
    // console.debug('delete', resp)
  };

  return (
    <TouchableRipple
      onPress={goToDetails}
      style={{ padding: 0, marginBottom: 12, marginHorizontal: 8 }}
    >
      <Card mode="elevated">
        <Card.Cover
          source={{ uri: receipeBase64Img(receipe) }}
          style={{ borderBottomLeftRadius: 0, borderBottomRightRadius: 0 }}
        />
        <Card.Title
          title={receipe.title}
          subtitle={`${receipe.portions_number} part(s)`}
          titleStyle={{
            color: Colors.black,
            fontSize: 24,
            fontWeight: '600',
          }}
          style={{ padding: 8 }}
          right={(props) => leftContent(props)}
        />
        <Card.Actions style={{ width: '100%' }}>
          <Button
            onPress={() => handleDelete()}
            icon="heart-circle-outline"
            textColor="orange"
            rippleColor="orange"
            mode="text"
            style={{ borderColor: 'orange' }}

          >
            Like
          </Button>
          <Button
            onPress={() => handleDelete()}
            icon="delete"
            textColor="red"
            rippleColor="red"
            mode="text"
          >
            Delete
          </Button>
        </Card.Actions>
      </Card>

    </TouchableRipple>
  );
};

export default ReceipeCard;
