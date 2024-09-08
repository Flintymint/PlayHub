package Model.User;

public class UserMessage {
	// Fields to hold the message content, type, and CSS class
	private String messageContent;
    private String messageType;
    private String messageCssClass;

    // Constructor to initialize the message content, type, and CSS class
    public UserMessage(String messageContent, String messageType, String messageCssClass) {
        this.messageContent = messageContent;
        this.messageType = messageType;
        this.messageCssClass = messageCssClass;
    }

    // Getter for retrieving the message content
    public String getMessageContent() {
        return messageContent;
    }
 
    // Setter for updating the message content
    public void setMessageContent(String messageContent) {
        this.messageContent = messageContent;
    }

    // Getter for retrieving the message type
    public String getMessageType() {
        return messageType;
    }
    
    // Setter for updating the message type
    public void setMessageType(String messageType) {
        this.messageType = messageType;
    }

    // Getter for retrieving the CSS class associated with the message
    public String getMessageCssClass() {
        return messageCssClass;
    }

    // Setter for updating the CSS class associated with the message
    public void setMessageCssClass(String messageCssClass) {
        this.messageCssClass = messageCssClass;
    }
}