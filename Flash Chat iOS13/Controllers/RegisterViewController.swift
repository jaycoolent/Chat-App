

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text , let password = passwordTextfield.text {
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription) // receive a localized description of this error.
                } else {
                    // Navigate to the Chat View Controller
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
        
    }
}
 // As you type the text field property its telling you that the text displayed is not a string but an optional String denoted by the ?. Can't simply just leave this as is  I'm gonna get the error telling me that the optional type String which refers to this one must be unwrapped to a value of type normal String in order for it to be used as an input to the email parameter and the same thing with password.So we can use what we learned about optional binding in order to turn the emailTextField.text into a real string. So to do that, we add the word "if" in front of the "let" and I'm going to chain these two things together.
    // if let email = emailTextField.text, let password = passwordTextField.text

    // What this does is it says if emailtextfield.text is not nil and it can be turned into a string stored inside this property called email, and the same thing with password. And only if both of these things do not fail, then do we continue to the next stage which is actually to create our user.
    // Inside closure we get access to authResult & error (if there is one). So what we do instead is optionally bind (if let)to a new constant "e" to the new error. (so if the error was not nil)(print(e)). This is an optional and we're going to turn it into a nonoptional if indeed there was an error. Next thing we'll add is an "else" in here because if there were no errors, then this block is going to get skipped and we're going to fail here.

    // If there were no errors, we want to navigate to the chat view controller

    // .self in front of segue because we are inside a closure and any method inside a closure must be identified with self.
