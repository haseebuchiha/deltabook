import React, { useState, useEffect } from 'react'
import axios from 'axios'
import Feed from './Feed'
import { Link } from 'react-router-dom'

const Feeds = () => {
    const [feedsArr, setFeedsArr] = useState([])
    useEffect(() => {

        axios.get('/api/v1/feeds.json')
            .then(resp => {
                setFeedsArr(resp.data)
            })
            .catch(resp => console.log(resp))
    }, [feedsArr.length])

    const handleDestroy = (id, e) => {
        e.preventDefault()
        axios.delete(`/api/v1/feeds/${id}`)
            .then(resp => {
                const newfeeds = feedsArr.filter(feed => feed.id !== id)
                setFeedsArr(newfeeds)
            })
            .catch(resp => console.log(resp))
    }

    const grid = feedsArr.map(item => {
        return (
            <Feed
                key={item.id}
                attributes={item}
                handleDestroy={handleDestroy}
            />)
    })

    return (
        <div className='container-fluid'>
            <div className="row">
                <div className="col col-sm-12 col-lg-3">
                    <h5 className="text-center">Total Feeds: {feedsArr.length}</h5>
                </div>

                <div className="col col-sm-12 col-lg-6">
                    <h3 className="text-center">Showing All Feeds</h3>
                    {grid}
                    <div className="text-center">
                        <Link to="/feeds/new" className="btn btn-outline-dark btn-lg mt-5">New Feed</Link>
                    </div>
                </div>

                <div className="col col-sm-12 col-lg-3">
                    <h5 className="text-center">Total Feeds: {feedsArr.length}</h5>
                </div>
            </div>
        </div>
    )
}

export default Feeds;