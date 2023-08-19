# How to Send Push Notifications to a Single Device

In Oxygen based backends, you can send push notifications for a single device. 

Broadcast **messages to all devices MUST NOT BE sent** after a project has gone live. Your must test only by sending messages to the testing device.



### Getting the Mobile’s IP address

**Step 1.** Install and open the App on your phone

**Step 2.** Close the App. On your phone, open a browser and go to http://eyep.dev/ to find the public IP address.



### Send the Notification

**Step 3.** Login to the Admin Panel and go to the ‘Devices’ Section.

**Step 4.** Search for the phone’s IP Address found from Step #2.

   ![20190911 - Push Notification Instructions.pdf (page 1 of 2) 2019-09-20 15-40-36.png](https://bitbucket.org/repo/qEKj8nK/images/3784364700-20190911%20-%20Push%20Notification%20Instructions.pdf%20%28page%201%20of%202%29%202019-09-20%2015-40-36.png)
   
   - If you do not get any results, the mobile is not registered to receive push notifications. Check the push notification settings on your phone, force-close the app, and repeat from Step #1 above.
   - If you get multiple results for the same IP address, on the phone, switch to 3G/4G data, and repeat from Step #1 above. (So that your phone will likely to get a new IP address)

**Step 5.** Click ‘Send Notification’ button to send a notification to the selected device.

**Step 6.** On the new notification screen, it should restrict sending to the selected device now.

    Leave the ‘Scheduled Send Time’ field empty to send the notification immediately.

![(https://bitbucket.org/repo/qEKj8nK/images/469916513-20190911%20-%20Push%20Notification%20Instructions.pdf%20%28page%201%20of%202%29%202019-09-20%2015-36-56.png)# Welcome](https://bitbucket.org/repo/qEKj8nK/images/2631829627-20190911%20-%20Push%20Notification%20Instructions.pdf%20%28page%202%20of%202%29%202019-09-20%2015-37-32.png)
  


## Required Dependencies

[Oxygen Push Notifications Package](https://bitbucket.org/elegantmedia/oxygen-push-notifications/)

[Oxygen Devices Package](https://bitbucket.org/elegantmedia/devices-laravel/)