import React, { useEffect, useState } from 'react';
import { ImageBackground, SafeAreaView, ScrollView, StatusBar, View } from 'react-native';
import { ingredientProperQuantity, receipeBase64Img } from '../utils/receipes';
import { ShowProps } from '../types/props';
import Markdown from 'react-native-markdown-display';
import { DataTable, Divider, List, TextInput as PaperTextInput } from 'react-native-paper';
import { Ingredient } from '../types/api';
import LinearGradient from 'react-native-linear-gradient';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { STATUS_BAR_COLOR } from '../styles/defaults';
import { useBaguetteBuddy } from '../contexts/BaguetteBuddyProvider';

const Show = ({ route }: ShowProps): React.JSX.Element => {
  const { markdownStyle } = useBaguetteBuddy();
  const { receipe } = route.params;
  const { portions_number } = receipe;
  const [currentPortions, setCurrentPortions] = useState(receipe.portions_number);
  const [expandedIngredients, setExpandedIngredients] = useState(true);
  const [portionsFactor, setPortionsFactor] = useState<number>(receipe.portions_number / currentPortions);

  useEffect(() => {
    setPortionsFactor(currentPortions / portions_number);
  }, [currentPortions, portions_number]);

  const toggleExpanded = () => setExpandedIngredients(!expandedIngredients);
  const expandIngredients = () => setExpandedIngredients(true);

  const handlePortionsChange = (val?: string) => {
    expandIngredients();
    if (val !== undefined && val.length > 0) {
      const parsedVal = parseInt(val, 10);
      setCurrentPortions(isNaN(parsedVal) || parsedVal < 1 ? 1 : parsedVal);
    } else {
      setCurrentPortions(1);
    }
  };

  return (
    <SafeAreaProvider>
      <SafeAreaView style={{ flexGrow: 1 }}>
        <StatusBar backgroundColor={STATUS_BAR_COLOR} barStyle={'light-content'} />
        <ScrollView
          contentInsetAdjustmentBehavior="automatic">
          <ImageBackground
            style={{ height: 220, width: '100%', marginBottom: 0, backgroundColor: 'rgba(0,0,0,0.5)' }}
            source={{ uri: receipeBase64Img(receipe) }}>
            <LinearGradient
              colors={[STATUS_BAR_COLOR, '#00000000']}
              style={{ height: '100%', width: '100%' }}>
              <PaperTextInput
                mode="flat"
                inputMode="numeric"
                keyboardType="numeric"
                label="portions"
                style={{
                  width: '30%',
                  bottom: 0,
                  right: 12,
                  position: 'absolute',
                  backgroundColor: '#fff',
                  borderTopStartRadius: 12,
                  borderTopEndRadius: 12
                }}
                onFocus={expandIngredients}
                right={<PaperTextInput.Affix text={`/${receipe.portions_number}`} />}
                value={currentPortions.toString()}
                onChangeText={handlePortionsChange} />

            </LinearGradient>
          </ImageBackground>
          <View style={{ paddingLeft: 12, paddingRight: 12 }}>
            {receipe.ingredients.length > 0 &&
              <List.Accordion
                title="Ingredients"
                id="1"
                onPress={toggleExpanded}
                expanded={expandedIngredients}>
                <DataTable>
                  <DataTable.Header>
                    <DataTable.Title>Article</DataTable.Title>
                    <DataTable.Title>For {portions_number}</DataTable.Title>
                    {portionsFactor !== 1 && <DataTable.Title>For {currentPortions} (x{portionsFactor})</DataTable.Title>}
                  </DataTable.Header>
                  {receipe.ingredients.map((ingredient: Ingredient) => (
                    <DataTable.Row key={ingredient.title}>
                      <DataTable.Cell>{ingredient.title}</DataTable.Cell>
                      <DataTable.Cell>{ingredientProperQuantity(ingredient, portionsFactor !== 1)}</DataTable.Cell>
                      {portionsFactor !== 1 && <DataTable.Cell>{ingredientProperQuantity(ingredient, true, portionsFactor)}</DataTable.Cell>}
                    </DataTable.Row>
                  ))}
                </DataTable>
              </List.Accordion>}
            <Divider style={{ marginVertical: 12 }} />
            <Markdown style={markdownStyle}>
              {receipe.description}
            </Markdown>

          </View>
        </ScrollView>
      </SafeAreaView>
    </SafeAreaProvider>
  )
}

export default Show;
