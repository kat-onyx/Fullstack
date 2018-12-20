import React from 'react';
import { connect } from 'react-redux';
import MessageIndex from './message_index';
import { fetchMessages, createMessage } from '../../actions/message_actions';
import { withRouter } from 'react-router-dom';

const mapStateToProps = (state, ownProps) => {
    // debugger
    const currentChannelId = ownProps.props.match.params.channelId;
    const currentChannelName = state.entities.channels[currentChannelId];
    const currentUserId = state.session.id;
    const currentServerId = ownProps.props.match.params.serverId;
    const user = {} || state.entities.users[currentUserId];
    const username = {} || user.username
     
    return { 
        messages: Object.values(state.entities.messages),
        currentChannelId,
        currentChannelName,
        currentUserId,
        currentServerId,
        username
    }
}

const mapDispatchToProps = (dispatch) => {
    return {
        fetchMessages: (id) => dispatch(fetchMessages(id)),
        createMessage: (message) => dispatch(createMessage(message))
    }
}

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(MessageIndex));