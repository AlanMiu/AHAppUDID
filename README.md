# AHAppUDID

**为每个App生成UDID并持久保存，支持卸载后找回，需要引用AHKeychain**

```objective-c
    // 获取UDID
    AHAppUDID *udid = [AHAppUDID udid];
    // 获取自定义标示的UDID
    AHAppUDID *udid4key = [AHAppUDID udid:@"KEY"];
```
