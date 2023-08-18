import React from "react";

const FormFeed = (props) => {
    return (
        <form onSubmit={props.handleSubmit} className="shadow p-3 mb-3 bg-dark text-white rounded">
            <div className="form-group row">
                <p className="col-2 col-form-label text-light">Feed Title</p>
                <div className="col-10">
                    <input onChange={props.handleChange} className="form-control shadow rounded" value={props.feed.title} name="title" placeholder="Write title here" />
                </div>
            </div>

            <div className="form-group row">
                <p className="col-2 col-form-label text-light">Description</p>
                <div className="col-10">
                    <input onChange={props.handleChange} className="form-control shadow rounded" value={props.feed.description} name="description" placeholder="Write description here" />
                </div>
            </div>

            <div className="form-group row justify-content-center">
                <button type="submit" className="btn btn-outline-light btn-lg">Create Feed</button>
            </div>
        </form>
    )
}

export default FormFeed;