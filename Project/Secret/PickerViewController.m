//
//  PickerViewController.m
//  Project
//
//  Created by Kai Peng on 1/29/13.
//  Copyright (c) 2013 Kai Peng. All rights reserved.
//

#import "PickerViewController.h"

@interface PickerViewController ()

@end

@implementation PickerViewController {

}
@synthesize PBBackground, PBForeground, chute, createdChute;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self hideProgressIndicator];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(progressIndicator:) name:GCUploaderProgressChanged object:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(dismissModalViewControllerAnimated:)];
    self.navigationItem.leftBarButtonItem = backButton;
    uploadButton = [[UIBarButtonItem alloc] initWithTitle:@"Upload" style:UIBarButtonItemStylePlain target:self action:@selector(uploadPhoto)];
    [uploadButton setEnabled:NO];
    self.navigationItem.rightBarButtonItem = uploadButton;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(drawText)];

    [self addLineDrawing];
}


- (void)addLineDrawing{
    drawView = [[MyLineDrawingView alloc] initWithFrame:self.view.frame];
    [drawView setBackgroundColor:[UIColor clearColor]];

    [self.view addSubview:drawView];
    [self.view sendSubviewToBack:drawView];
    [self.view sendSubviewToBack:self.selectedImageView];
}




-(void)drawText {
    
}

-(void)uploadPhoto{
    if([[self selectedImageView] image] == nil)
        return;
    UIImage *editedImage = [PickerViewController drawDrawing:drawView inImage:[[self selectedImageView] image]];
    [GCUploader uploadImage:editedImage toChute:chute save:NO withCompression:.05];
    [uploadButton setEnabled:NO];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if(!chute){
        //[GCLoginViewController presentInController:self];
        [[GCAccount sharedManager] setAccessToken:kOAuthToken];
        if([[GCAccount sharedManager] accessToken]){
            [GCChute findById:@"2369119" inBackgroundWithCompletion:^(GCResponse *response){
                if([response isSuccessful]){
                    NSLog(@"Match found on Chute");
                    [self setChute:[response object]];
                    [uploadButton setEnabled:YES];
                }else{
                    NSLog(@"Match NOT found on Chute");
                }
            }];
            /*}
            else{
                createdChute = [GCChute new];
                NSLog(@"New Chute Created");

                [createdChute setName:@"Uploads"];
                [createdChute setPermissionView:GCPermissionTypeMembers];
                [createdChute setPermissionAddMembers:GCPermissionTypeMembers];
                [createdChute setPermissionAddPhotos:GCPermissionTypeMembers];
                [createdChute setPermissionAddComments:GCPermissionTypeMembers];
                [createdChute setModeratePhotos:GCPermissionTypePublic];
                [createdChute setModerateMembers:GCPermissionTypePublic];
                [createdChute setModerateComments:GCPermissionTypePublic];
                NSLog(@"New Chute Saving");

                [createdChute saveInBackgroundWithCompletion:^(BOOL success, NSError *error){
                    if(success){
                        NSLog(@"New Chute Created Successfully");

                        [[NSUserDefaults standardUserDefaults] setObject:[createdChute objectID] forKey:@"chuteID"];
                        [self setChute:createdChute];
                    }
                }];
            }*/
        }else{
            NSLog(@"Access Token Failed, %@", [[GCAccount sharedManager] accessToken].description);
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setPBForeground:nil];
    [self setPBBackground:nil];
    [self setUploaderButton:nil];
    [self setGalleryButton:nil];
    [super viewDidUnload];
}
- (void) showProgressIndicator {
    [PBBackground setHidden:NO];
    [PBForeground setHidden:NO];
}

- (void) hideProgressIndicator {
    [PBBackground setHidden:YES];
    [PBForeground setHidden:YES];
}

- (void) progressIndicator:(NSNotification *) notification {
    if ([[GCUploader sharedUploader] progress] > 0 && [[GCUploader sharedUploader] progress] < 1) {
        [self showProgressIndicator];
        
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            [PBForeground setFrame:CGRectMake(PBForeground.frame.origin.x, PBForeground.frame.origin.y, 300*[[GCUploader sharedUploader] progress], 20)];
        } completion:^(BOOL finished) {}];
        return;
    }
    [self hideProgressIndicator];
    //[uploadButton setEnabled:YES];
}

-(void)popupSelector {
    PhotoPickerPlus *temp = [[PhotoPickerPlus alloc] init];
    [temp setDelegate:self];
    [temp setModalPresentationStyle:UIModalPresentationCurrentContext];
    [self presentViewController:temp animated:YES completion:^(void){
        //[self dismissModalViewControllerAnimated:YES];
    }];
}

-(IBAction)showUploader{
    /*UploadPickerViewController *picker = [[UploadPickerViewController alloc] init];
    [picker setChute:[self chute]];
    [[self navigationController] pushViewController:picker animated:YES];
    */
    [self popupSelector];
}

-(IBAction)showGallery{
    /*GCResponse *response = [[self chute] assets];
    if([response isSuccessful]){
        GCCloudGallery *gallery = [[GCCloudGallery alloc] init];
        [gallery setObjects:[response object]];
        [[self navigationController] pushViewController:gallery animated:YES];
    }*/

}

-(void) PhotoPickerPlusControllerDidCancel:(PhotoPickerPlus *)picker{
    //cancel code
    [self dismissViewControllerAnimated:YES completion:^(void){
        
    
    }];
    
}
-(void) PhotoPickerPlusController:(PhotoPickerPlus *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //image picked code
    [self dismissViewControllerAnimated:YES completion:^(void){
        [[self selectedImageView] setImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
    }];
    
}

+(UIImage*) drawText:(NSString*) text
             inImage:(UIImage*)  image
             atPoint:(CGPoint)   point
{
    
    UIFont *font = [UIFont boldSystemFontOfSize:12];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    [[UIColor whiteColor] set];
    [text drawInRect:CGRectIntegral(rect) withFont:font];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(UIImage*) drawDrawing:(UIView*) drawing
             inImage:(UIImage*)  image
{
    
    //UIFont *font = [UIFont boldSystemFontOfSize:12];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(0,0, image.size.width, image.size.height);
    [[UIColor whiteColor] set];
    [drawing drawRect:CGRectIntegral(rect)];
    //[drawing drawInRect:CGRectIntegral(rect) withFont:font];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
