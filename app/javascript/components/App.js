import React, { Component } from 'react'
import { Route, Switch, Routes } from 'react-router-dom'
import Feed from './Feed/Feed';
import Feeds from './Feeds/Feeds';
import NewFeed from './Feed/New';
import EditFeed from './Feed/Edit';

const App = () => {
    return (
        <>
            <Routes>
                <Route path='/feeds' element={<Feeds />}></Route>
                <Route path='/feeds/new' element={<NewFeed />}></Route>
                <Route path='/feed/:id' element={<Feed />}></Route>
                <Route path='/feed/:id/edit' element={<EditFeed />}></Route>
            </Routes>
        </>
    );
}

export default App;