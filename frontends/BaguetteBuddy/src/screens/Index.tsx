import React, { useCallback, useEffect, useState } from 'react';
import { RefreshControl, SafeAreaView, ScrollView, Text } from 'react-native';
import ReceipeCard from '../components/ReceipeCard';
import { IndexProps } from '../types/props';
import { AnimatedFAB, Appbar, Searchbar } from 'react-native-paper';
import { useBaguetteBuddy } from '../contexts/BaguetteBuddyProvider';

const Index = ({ }: IndexProps): React.JSX.Element => {
  const { loading, receipes, refreshReceipes } = useBaguetteBuddy();
  const [isExtended, setExtended] = useState(false);
  const [searchQuery, setSearchQuery] = useState('');
  const [showSearch, setShowSearch] = useState(false);
  const [cReceipes, setCReceipes] = useState(receipes)

  const onScroll = ({ nativeEvent }) => {
    const currentScrollPos = Math.floor(nativeEvent?.contentOffset?.y) ?? 0;
    setExtended(currentScrollPos > 0);
  };

  const onRefresh = useCallback(() => {
    refreshReceipes();
  }, [refreshReceipes]);

  useEffect(() => {
    if (searchQuery && searchQuery.length > 0) {
      setCReceipes(receipes.filter((r) => r.title.toLowerCase().includes(searchQuery.toLowerCase())));
    } else {
      setCReceipes(receipes);
    }
  }, [searchQuery, receipes]);

  return (
    <SafeAreaView style={{ flexGrow: 1, paddingHorizontal: 2 }}>
      <Appbar.Header style={{ backgroundColor: 'transparent' }} >
        {!showSearch && (
          <>
            <Appbar.Content title="Receipes" />
            <Appbar.Action icon="magnify" isLeading onPress={() => setShowSearch(true)} />
          </>
        )}
        {showSearch && <Searchbar
          placeholder="Search"
          onChangeText={setSearchQuery}
          style={{ transformOrigin: 'right', transform: '0.5s, transform 0.5s' }}
          onIconPress={() => setShowSearch(false)}
          value={searchQuery}
          onClearIconPress={() => setShowSearch(false)}
        />}
      </Appbar.Header>
      <ScrollView
        style={{ padding: 4 }}
        onScroll={onScroll}
        contentInsetAdjustmentBehavior="automatic"
        refreshControl={
          <RefreshControl refreshing={loading} onRefresh={onRefresh} />
        }
      >
        {loading ? <Text>Chargement...</Text> : <>
          {cReceipes.map((receipe, index) => <ReceipeCard receipe={receipe} key={index} />)}
        </>}
      </ScrollView>
      <AnimatedFAB
        icon={'plus'}
        label={'Add'}
        extended={isExtended}
        animateFrom={'right'}
        visible={true}
        style={{
          bottom: 16,
          right: 16,
          position: 'absolute',
          borderRadius: 150
        }}
      />
    </SafeAreaView>
  );
};

export default Index;

