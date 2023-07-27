import React from "react";
import { BrowserRouter, Link } from "react-router-dom";

const Feed = (props) => {
    return (
        <div class="col card text-center mt-4 rounded-lg shadow">
            <div class="row">

                <div class="col col-3 bg-dark text-white d-flex justify-content-center align-items-center">
                    <h5 class="mb-3"><small>by</small><br />Random User</h5>
                </div>

                <div class="col col-7">
                    <div class="card-body">
                        <h5 class="card-title">{props.attributes.title}</h5>
                        <hr />
                        <p class="card-text">{props.attributes.description}</p>
                    </div>
                    <hr />
                    <div class="text-muted mb-3">
                        <small> Created {props.attributes.created_at} ago,
                            Edited {props.attributes.updated_at} ago</small>
                    </div>
                </div>
                <div class="col col-2 d-flex flex-column justify-content-around bg-light py-3">
                    <Link to={`/feed/${props.attributes.id}`} className="btn btn-outline-primary">Show</Link>
                    <Link to={`/feed/${props.attributes.id}/edit`} className="btn btn-outline-success">Edit</Link>
                    <button className="btn btn-outline-danger" onClick={(e) => props.handleDestroy(props.attributes.id, e)}>Delete</button>
                </div>
            </div>
        </div >
    )

}

export default Feed;