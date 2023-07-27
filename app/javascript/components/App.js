import React, { Component } from 'react'
import { Route, Switch, Routes } from 'react-router-dom'
import Feed from './Feed/Feed';
import Feeds from './Feeds/Feeds';
import NewFeed from './Feed/New';


const App = () => {
    return (
        <>
            <Routes>
                <Route path='/feeds' element={<Feeds />}></Route>
                <Route exact path='/feeds/new' element={<NewFeed />}></Route>
                <Route exact path='/feed/:id' element={<Feed />}></Route>
            </Routes>
        </>
    );
}

export default App;