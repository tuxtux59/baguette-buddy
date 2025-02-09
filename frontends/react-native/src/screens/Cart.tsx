import React, { useState } from 'react';
import { SafeAreaView, ScrollView } from 'react-native';
import { List, SegmentedButtons, Text } from 'react-native-paper';

type Tabs = 'favorites' | 'shopping_list' | 'stock'

const Cart = ({ }): React.JSX.Element => {
  const [tab, setTab] = useState<Tabs>('favorites');

  return <SafeAreaView style={{ paddingLeft: 4, paddingRight: 4, paddingTop: 4, flexGrow: 1 }}>
    <Text variant="headlineSmall" style={{ textAlign: 'center' }}>Cart</Text>
    <SegmentedButtons
      value={tab}
      onValueChange={setTab}
      density="medium"
      style={{ width: '90%', fontSize: 12, marginHorizontal: '5%' }}
      buttons={[
        { value: 'favorites', label: 'Favorites' },
        { value: 'shopping_list', label: 'Shopping list' },
        { value: 'stock', label: 'Stock' },
      ]}
    />
    <ScrollView
      style={{ padding: 4 }}
      contentInsetAdjustmentBehavior="automatic"
    >
      {tab === 'favorites' && <List.Section>
        <List.Subheader>Liked receipes</List.Subheader>
        <List.Item title="Chicken" left={() => <List.Icon icon="food-turkey" />} />
        <List.Item
          title="Noodles"
          left={() => <List.Icon color={'orange'} icon="noodles" />}
        />
      </List.Section>}
      {tab === 'shopping_list' && <List.Section>
        <List.Subheader>Shopping list</List.Subheader>
        <List.Item title="Salt" left={() => <List.Icon icon="shaker" />} />
        <List.Item
          title="Pepper"
          left={() => <List.Icon color={'orange'} icon="chili-mild" />}
        />
      </List.Section>}
      {tab === 'stock' && <List.Section>
        <List.Subheader>Stock</List.Subheader>
        <List.Item title="Oil" left={() => <List.Icon icon="oil-lamp" />} />
        <List.Item
          title="Baguette"
          left={() => <List.Icon color={'orange'} icon="baguette" />}
        />
      </List.Section>}

    </ScrollView>
  </SafeAreaView>;
};

export default Cart;

