//
//  DFMRestError.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 15/06/2024.
//

import Foundation
import AnyCodable

enum DFMRestErrorType: Int, Codable, CaseIterableDefaultsLast {
    case unknownAccount = 10001
    case unknownApplication = 10002
    case unknownChannel = 10003
    case unknownGuild = 10004
    case unknownIntegration = 10005
    case unknownInvite = 10006
    case unknownMember = 10007
    case unknownMessage = 10008
    case unknownPermissionOverwrite = 10009
    case unknownProvider = 10010
    case unknownRole = 10011
    case unknownToken = 10012
    case unknownUser = 10013
    case unknownEmoji = 10014
    case unknownWebhook = 10015
    case unknownWebhookService = 10016
    case unknownConnection = 10017
    case unknownSession = 10020
    case unknownAsset = 10021
    case unknownApprovalForm = 10023
    case unknownBan = 10026
    case unknownSKU = 10027
    case unknownStoreListing = 10028
    case unknownEntitlement = 10029
    case unknownBuild = 10030
    case unknownLobby = 10031
    case unknownBranch = 10032
    case unknownStoreDirectoryLayout = 10033
    case unknownPriceTier = 10035
    case unknownRedistributable = 10036
    case unknownGiftCode = 10038
    case unknownTeam = 10039
    case unknownTeamMember = 10040
    case unknownManifestLabels = 10042
    case unknownAchievement = 10043
    case unknownEULA = 10044
    case unknownApplicationNews = 10045
    case channelNotAssociatedWithSKU = 10046
    case unknownPremiumGuildSubscription = 10047
    case unknownGiftCodeBatch = 10048
    case unknownStream = 10049
    case unknownPremiumServerSubscribeCooldown = 10050
    case unknownPayout = 10053
    case unknownPremiumGuildSubscriptionSlot = 10055
    case unknownRemoteAuthenticationSession = 10056
    case unknownServerTemplate = 10057
    case unknownUserIdentityVerification = 10058
    case unknownDiscoverableServerCategory = 10059
    case unknownSticker = 10060
    case unknownStickerPack = 10061
    case unknownInteraction = 10062
    case unknownApplicationCommand = 10063
    case unknownUserTrialOffer = 10064
    case unknownVoiceState = 10065
    case unknownApplicationCommandPermissions = 10066
    case unknownStageInstance = 10067
    case unknownGuildMemberVerificationForm = 10068
    case unknownGuildWelcomeScreen = 10069
    case unknownGuildScheduledEvent = 10070
    case unknownGuildScheduledEventUser = 10071
    case unknownSubscriptionPlan = 10073
    case unknownDirectoryEntry = 10075
    case unknownPromotion = 10076
    case endpointNotAvailable = 10077
    case unknownSurvey = 10082
    case unknownServerRoleSubscriptionSettings = 10083
    case premiumUsageNotAvailable = 10084
    case unknownCreatorMonetizationEnableRequest = 10085
    case unknownTag = 10087
    case unknownFeaturedItem = 10091
    case unknownWebAuthnAuthenticator = 10093
    case unknownUserCode = 10094
    case unknownChannelForNewMemberAction = 10095
    case unknownMessageAttachment = 10096
    case unknownSound = 10097
    case unknownGameInvite = 10099
    case unknownPoll = 10102
    case unknownSnapshot = 10105
    case unknownTenureRewardStatus = 10111
    case unknownGooglePlayPackageName = 10112
    case guildIsNotAClan = 10113
    case botsCannotUseEndpoint = 20001
    case onlyBotsCanUseEndpoint = 20002
    case rpcProxyDisallowed = 20003
    case explicitContentNotAllowed = 20009
    case accountScheduledForDeletion = 20011
    case unauthorizedActionOnApplication = 20012
    case accountDisabled = 20013
    case premiumSubscriptionRequired = 20015
    case slowmodeRateLimit = 20016
    case mazeNotForYou = 20017
    case ownerOnlyAction = 20018
    case teamInvitationRequired = 20019
    case skuNotAvailableForPurchase = 20020
    case phoneVerificationRequiredForFriendSync = 20021
    case announcementRateLimit = 20022
    case unrecognizedLocalAccountProvider = 20023
    case underMinimumAge = 20024
    case contactSupportForVerifiedApplication = 20025
    case botFlaggedForAbusiveBehavior = 20026
    case approvedStoreApplicationsOnly = 20027
    case channelWriteRateLimit = 20028
    case serverWriteRateLimit = 20029
    case forbiddenWordsInStageTopic = 20031
    case updateNotAllowedForConnectionType = 20033
    case guildPremiumSubscriptionLevelTooLow = 20035
    case friendsOnlyAction = 20037
    case contactSupportForVerifiedTeam = 20039
    case vanityUrlRequiredForPublishedGuilds = 20040
    case invalidRemoteAuthenticationTicket = 20042
    case vanityUrlEmployeeOnlyGuildDisabled = 20044
    case guildDoesNotMeetVanityUrlRequirements = 20045
    case noMembersForNewRoleRequirements = 20054
    case applicationRestrictedFromJoiningServer = 20055
    case maxGuildsReached = 30001
    case maxFriendsReached = 30002
    case maxPinsReached = 30003
    case maxRecipientsReached = 30004
    case maxGuildRolesReached = 30005
    case tooManyUsersWithThisUsername = 30006
    case maxWebhooksReached = 30007
    case maxEmojisReached = 30008
    case maxConnectionsReached = 30009
    case maxReactionsReached = 30010
    case maxGroupDMsReached = 30011
    case maxWhitelistedUsersReached = 30012
    case maxGuildChannelsReached = 30013
    case maxAttachmentsReached = 30015
    case maxInvitesReached = 30016
    case maxApplicationAssetsReached = 30017
    case maxAnimatedEmojisReached = 30018
    case maxServerMembersReached = 30019
    case maxGameSKUsPerApplicationReached = 30021
    case maxGiftsReachedForSKU = 30022
    case maxTeamsReached = 30023
    case maxCompaniesReached = 30025
    case maxPremiumServerSubscriptionsReached = 30026
    case notEnoughGuildMembers = 30029
    case maxServerCategoriesReached = 30030
    case guildAlreadyHasTemplate = 30031
    case maxApplicationCommandsReached = 30032
    case maxThreadParticipantsReached = 30033
    case maxDailyApplicationCommandCreatesReached = 30034
    case maxNonGuildMemberBansExceeded = 30035
    case maxBanFetchesReached = 30037
    case maxUncompletedGuildScheduledEventsReached = 30038
    case maxStickersReached = 30039
    case maxPruneRequestsReached = 30040
    case maxDirectoryChannelEntriesReached = 30041
    case maxGuildWidgetSettingsUpdatesReached = 30042
    case maxPublishedTiersReached = 30043
    case maxSoundboardSoundsReached = 30045
    case maxMessageEditsOlderThan1HourReached = 30046
    case maxPinnedThreadsInForumChannelReached = 30047
    case maxTagsInForumChannelReached = 30048
    case bitrateTooHighForChannelType = 30052
    case maxTotalAttachmentSizeReached = 30053
    case maxPublishedApplicationSubscriptionsReached = 30054
    case maxSubscriptionGroupListingsReached = 30055
    case maxPremiumEmojisReached = 30056
    case maxWebhooksPerGuildReached = 30058
    case maxBlockedUsersReached = 30059
    case maxChannelPermissionOverwritesReached = 30060
    case guildChannelsTooLarge = 30061
    case maxApplicationSubscriptionSKUsReached = 30063
    case maxPublishedProductsReached = 30065
    case maxSnapshotsReached = 30066
    case maxGuildIntegrationsReached = 30068
    case rateLimited = 31001
    case resourceRateLimited = 31002
    case unauthorized = 40001
    case verifyAccountRequired = 40002
    case openingDirectMessagesTooFast = 40003
    case sendMessageDisabled = 40004
    case requestEntityTooLarge = 40005
    case featureTemporarilyDisabled = 40006
    case userBannedFromGuild = 40007
    case alreadyHaveVerifiedPhone = 40010
    case transferOwnershipBeforeDeletingAccount = 40011
    case connectionRevoked = 40012
    case accountMustBeClaimed = 40013
    case activityExpired = 40014
    case transferOwnershipBeforeDisablingAccount = 40015
    case serviceUnavailable = 40016
    case cannotUpdatePrivacySettings = 40021
    case teamMemberAlreadyExists = 40024
    case teamOwnerCannotBeDeleted = 40025
    case allTeamMembersMustHaveVerifiedEmail = 40026
    case alreadyTeamMember = 40027
    case transferOwnershipBeforeDeletingAccountTeam = 40028
    case companyWithNameAlreadyExists = 40029
    case targetUserNotConnectedToVoice = 40032
    case messageAlreadyCrossposted = 40033
    case userDisabledContactSync = 40034
    case userIdentityVerificationProcessing = 40035
    case userIdentityVerificationSucceeded = 40036
    case applicationVerificationIneligible = 40037
    case applicationVerificationSubmitted = 40038
    case applicationVerificationApproved = 40039
    case applicationCommandWithNameAlreadyExists = 40041
    case applicationInteractionFailedToSend = 40043
    case entryAlreadyExistsInDirectoryChannel = 40044
    case noOutboundPromotionCodeToClaim = 40046
    case applicationMustBeVerifiedToRequestIntents = 40053
    case recommendationsNotAvailable = 40054
    case cannotMessageThreadUntilAuthorPosts = 40058
    case interactionAlreadyAcknowledged = 40060
    case tagNamesMustBeUnique = 40061
    case serviceResourceRateLimited = 40062
    case applicationNeedsVerification = 40064
    case noTagsAvailableForNonModerators = 40066
    case tagRequiredToCreateForumPost = 40067
    case userQuarantine = 40068
    case invitesPausedForServer = 40069
    case trialSubscriptionsNotEligibleForPromotion = 40071
    case couldNotVerifyPhoneNumber = 40073
    case newMemberActionCompleted = 40075
    case findFriendsUnavailable = 40077
    case invalidRecipientForFriendInvite = 40081
    case invalidCodeForFriendInvite = 40082
    case cannotKickClydeAIBot = 40088
    case verifiedApplicationsCannotBeEmbedded = 40090
    case serverIneligibleToBecomeGuild = 40092
    case internalNetworkError = 40333
    case missingAccess = 50001
    case invalidAccountType = 50002
    case cannotExecuteActionOnDMChannel = 50003
    case guildWidgetDisabled = 50004
    case cannotEditMessageByAnotherUser = 50005
    case cannotSendEmptyMessage = 50006
    case cannotSendMessageToUser = 50007
    case cannotSendMessageInNonTextChannel = 50008
    case channelVerificationTooHigh = 50009
    case oauth2ApplicationHasNoBot = 50010
    case oauth2ApplicationLimitReached = 50011
    case invalidOAuth2State = 50012
    case missingPermissions = 50013
    case invalidAuthToken = 50014
    case noteTooLong = 50015
    case tooFewOrTooManyMessagesToDelete = 50016
    case invalidMFALevel = 50017
    case passwordDoesNotMatch = 50018
    case messageCanOnlyBePinnedInSentChannel = 50019
    case invalidOrTakenInviteCode = 50020
    case cannotExecuteActionOnSystemMessage = 50021
    case invalidPhoneNumber = 50022
    case invalidClientID = 50023
    case cannotExecuteActionOnChannelType = 50024
    case invalidOAuth2AccessToken = 50025
    case missingRequiredOAuth2Scope = 50026
    case invalidWebhookToken = 50027
    case invalidRole = 50028
    case unverifiedEmailsCannotBeAddedToWhitelist = 50029
    case cannotInviteYourselfToWhitelist = 50030
    case cannotInviteAlreadyWhitelistedOrMember = 50031
    case invalidRecipients = 50033
    case messageTooOldToBulkDelete = 50034
    case invalidFormBody = 50035
    case inviteAcceptedToGuildBotNotIn = 50036
    case invalidVerificationCode = 50037
    case cannotPerformActionOnYourself = 50038
    case invalidActivityAction = 50039
    case invalidOAuth2RedirectURI = 50040
    case invalidAPIVersion = 50041
    case invalidBillingState = 50042
    case dataHarvestPending = 50043
    case dataHarvestRequestLimit = 50044
    case fileUploadedExceedsMaxSize = 50045
    case invalidAsset = 50046
    case invalidPaymentSource = 50048
    case giftAlreadyRedeemed = 50050
    case alreadyOwnThisSKU = 50051
    case cannotSelfRedeemGift = 50054
    case invalidGuild = 50055
    case cannotDeleteAssetInUseOnStorePage = 50056
    case invalidSKU = 50057
    case cannotApplyLicenceToActivatedApplication = 50058
    case applicationCannotBeSubmittedForApproval = 50059
    case invalidApplicationStoreState = 50060
    case cannotUnsubscribeFromServerAgain = 50064
    case invalidRequestOrigin = 50067
    case invalidMessageType = 50068
    case mustWaitForPremiumServerSubscriptionCooldown = 50069
    case paymentSourceRequiredToRedeemGift = 50070
    case newSubscriptionRequiredToRedeemGift = 50071
    case cannotModifySystemWebhook = 50073
    case cannotDeleteRequiredCommunityChannel = 50074
    case cannotEditStickersInMessage = 50080
    case cannotUseSticker = 50081
    case operationOnArchivedThread = 50083
    case invalidThreadNotificationSettings = 50084
    case beforeValueEarlierThanThreadCreationDate = 50085
    case communityServerChannelsMustBeText = 50086
    case eventEntityTypeMismatch = 50091
    case alreadyOwnedSKU = 50092
    case invalidDirectoryEntryType = 50094
    case serverUnavailableInLocation = 50095
    case cannotAcceptOwnFriendInvite = 50096
    case serverNeedsMonetizationEnabled = 50097
    case entityOnlyEditableThroughServerSettings = 50099
    case serverNeedsMoreBoosts = 50101
    case cannotUpdatePriceTierOnPublishedRoleListing = 50102
    case malformedUserSettingsPayload = 50104
    case userSettingsFailedValidation = 50105
    case noAccessToRequestedActivity = 50106
    case serverNeedsMoreBoostsForActivity = 50107
    case invalidActivityLaunchConcurrentActivities = 50108
    case requestBodyContainsInvalidJSON = 50109
    case invalidFileProvided = 50110
    case invalidGuildJoinRequestApplicationStatus = 50111
    case cannotDeleteSubscriptionGroupWithListings = 50112
    case cannotCreateMoreThanOneSubscriptionGroup = 50113
    case guildNotAllowedToUseMonetizationFeatures = 50119
    case serverIneligibleForMonetizationRequest = 50121
    case invalidFileTypeProvided = 50123
    case fileDurationExceedsMaxLimit = 50124
    case mustHaveNitroToLaunchActivity = 50129
    case ownerCannotBePendingMember = 50131
    case ownershipCannotBeTransferredToBotUser = 50132
    case userAlreadyOwner = 50133
    case userNoAccessToPrivateChannel = 50136
    case assetResizeFailedBelowMaxSize = 50138
    case userNotFound = 50139
    case userNotStaff = 50140
    case cannotMixSubscriptionAndNonSubscriptionRoles = 50144
    case cannotConvertBetweenPremiumAndNormalEmoji = 50145
    case uploadedFileNotFound = 50146
    case invalidConnection = 50147
    case cannotLaunchActivityInAFKChannel = 50148
    case invalidRoleConfiguration = 50150
    case specifiedEmojiInvalid = 50151
    case serverIneligibleForStorePages = 50152
    case serverNotAllowedToCreateEnableRequest = 50155
    case cannotDeleteSubscriptionListingWithSubscriptions = 50157
    case onboardingResponsesInvalid = 50158
    case voiceMessagesDoNotSupportAdditionalContent = 50159
    case voiceMessagesMustHaveSingleAudioAttachment = 50160
    case voiceMessagesMustHaveSupportingMetadata = 50161
    case voiceMessagesCannotBeEdited = 50162
    case cannotDeleteGuildSubscriptionIntegration = 50163
    case newOwnerIneligibleForSubscriptionRequirement = 50164
    case cannotLaunchAgeGatedActivity = 50165
    case onlyDiscoverableServersCanPublishLandingPage = 50166
    case cannotSendSoundboardSoundWhenMuted = 50167
    case userMustBeInVoiceChannelForVoiceEffect = 50168
    case cannotUpdateGuildFieldsWhenDisablingInvites = 50169
    case cannotSpecifyChannelAndGuildID = 50170
    case actionCannotBePerformedWithExistingTier = 50171
    case cannotSendVoiceMessagesInChannel = 50173
    case invalidClip = 50174
    case userAccountMustBeVerifiedFirst = 50178
    case onlyMediaChannelPostCanHavePreview = 50179
    case cannotSetHideMediaDownloadOptionForNonMediaChannels = 50182
    case onlyCommunityServersCanCreatePermanentInviteLinks = 50183
    case userNotEligibleForSendingRemix = 50184
    case archiveFilesNotSupported = 50186
    case unableToValidateDomain = 50187
    case invalidGuildFeature = 50188
    case applicationUnableToMonetize = 50191
    case invalidPromotion = 50193
    case giftCodeBelongsToSomeoneElse = 50194
    case guildsCannotBeSpecifiedForUserInstallation = 50196
    case invalidScopesForUserInstallation = 50197
    case installationTypeNotSupported = 50199
    case cannotLaunchActivityInLargeServer = 50209
    case invalidActivityLocation = 50220
    case noPermissionToSendSticker = 50600
    case accountAlreadyEnrolledInTwoFactorAuth = 60001
    case accountNotEnrolledInTwoFactorAuth = 60002
    case twoFactorRequiredForOperation = 60003
    case mustBeVerifiedAccount = 60004
    case invalidTwoFactorSecret = 60005
    case invalidTwoFactorAuthTicket = 60006
    case invalidTwoFactorCode = 60008
    case invalidTwoFactorSession = 60009
    case accountNotEnrolledInSMSAuth = 60010
    case invalidKey = 60011
    case smsAuthNotEnabledOnAccount = 60012
    case mfaRequiredForServerShopAdmins = 60015
    case userNotEligibleForMFAEmailVerification = 60019
    case unableToSendSMSMessage = 70003
    case phoneNumberUsedOnDifferentAccount = 70004
    case invalidPhoneNumberType = 70005
    case phoneVerificationRequired = 70007
    case phoneNumberAlreadyInUse = 70008
    case passwordResetLinkSentToEmail = 70009
    case incomingFriendRequestsDisabled = 80000
    case friendRequestBlocked = 80001
    case botsCannotHaveFriends = 80002
    case cannotSendFriendRequestToSelf = 80003
    case noUsersWithDiscordTagExist = 80004
    case noIncomingFriendRequestFromUser = 80005
    case needToBeFriendsForAction = 80006
    case alreadyFriendsWithUser = 80007
    case discriminatorRequired = 80008
    case reactionBlocked = 90001
    case userCannotUseBurstReactions = 90002
    case noAvailableBurstCurrencyForUser = 90003
    case invalidReactionType = 90004
    case invalidUpdateForMessageRequest = 90100
    case unknownBillingProfile = 100001
    case invalidPaymentSourceDuplicate = 100002
    case invalidSubscription = 100003
    case alreadySubscribed = 100004
    case invalidPlan = 100005
    case paymentSourceRequired = 100006
    case alreadyCanceled = 100007
    case invalidPayment = 100008
    case alreadyRefunded = 100009
    case invalidBillingAddress = 100010
    case alreadyPurchased = 100011
    case validDependentSKUEntitlementRequired = 100015
    case purchaseRequestInvalid = 100017
    case paymentRequired = 100018
    case userIneligibleForTrial = 100019
    case invalidAppleReceipt = 100021
    case invalidGiftRedemptionSubscriptionIncompatible = 100023
    case invalidGiftRedemptionInvoiceOpen = 100024
    case purchaseAmountBelowMinimum = 100026
    case invoiceAmountCannotBeNegative = 100027
    case authenticationRequired = 100029
    case invalidSubscriptionItem = 100034
    case trialSubscriptionCannotBeModified = 100035
    case subscriptionItemsRequired = 100037
    case cannotPreviewSubscriptionUpdate = 100038
    case invalidSubscriptionItems = 100040
    case subscriptionRenewalInProgress = 100042
    case invalidPriceTierOrder = 100046
    case confirmationRequired = 100047
    case couldNotProcessRefund = 100048
    case invalidCurrencyForPayment = 100051
    case invalidCurrencyForSubscriptionPlan = 100052
    case ineligibleForSubscription = 100053
    case insufficientFundsForPurchase = 100054
    case pendingPurchaseVerificationFailed = 100055
    case clientNeedsAuthorizationForPurchases = 100056
    case paymentMethodCannotBeUsed = 100058
    case openInvoiceNotFound = 100059
    case nonRefundablePaymentSource = 100060
    case invalidSubscriptionMetadata = 100062
    case currencyCannotBeChangedWithoutPaymentSource = 100066
    case invalidOperation = 100069
    case billingAppleServerAPIError = 100070
    case userNotEligibleForCreatingReferrals = 100071
    case errorGeneratingInvoicePDF = 100076
    case billingTrialRedemptionDisabled = 100078
    case pauseTemporarilyUnavailable = 100079
    case billingPausePendingAlreadySet = 100080
    case billingPauseNotEligible = 100081
    case invalidPauseInterval = 100082
    case billingAlreadyPaused = 100083
    case billingCannotChargeZeroAmount = 100084
    case invalidUpdateForPausedOrPausePendingSubscription = 100094
    case pauseSubscriptionNotAvailableForPlan = 100095
    case bundleAlreadyPurchased = 100096
    case bundleAlreadyPartiallyOwned = 100097
    case indexNotYetAvailable = 110000
    case applicationNotYetAvailable = 110001
    case listingAlreadyJoined = 120000
    case listingTooManyMembers = 120001
    case listingJoinBlocked = 120002
    case resourceOverloaded = 130000
    case maximumAchievementsReached = 140000
    case serverDoesNotPassPartnerRequirements = 150001
    case revokeExistingJoinRequestRequired = 150002
    case pendingApplicationNotFound = 150003
    case alreadyHavePendingPartnerApplication = 150004
    case stageAlreadyOpen = 150006
    case cannotAcknowledgeJoinRequest = 150008
    case userAlreadyMemberJoinRequestClosed = 150009
    case serverMustRaiseVerificationLevel = 150011
    case joinRequestNotFound = 150016
    case noPermissionToSeeJoinRequest = 150018
    case cannotCreateOrJoinInterview = 150019
    case joinRequestInterviewsNotAvailable = 150020
    case cannotReplyWithoutPermissionToReadMessageHistory = 160002
    case threadAlreadyCreatedForMessage = 160004
    case threadIsLocked = 160005
    case maximumActiveThreadsReached = 160006
    case maximumActiveAnnouncementThreadsReached = 160007
    case invalidJSONForUploadedLottieFile = 170001
    case uploadedLottiesCannotContainRasterizedImages = 170002
    case stickerMaximumFramerateExceeded = 170003
    case stickerFrameCountExceedsMaximum = 170004
    case lottieAnimationMaximumDimensionsExceeded = 170005
    case stickerFrameRateOutOfRange = 170006
    case stickerAnimationDurationExceedsMaximum = 170007
    case poggermodeTemporarilyDisabled = 170008
    case cannotUpdateFinishedEvent = 180000
    case exactlyOneGuildIDQueryParamRequired = 180001
    case failedToCreateStageForEvent = 180002
    case mustJoinServerToTakeAction = 180003
    case routeRequiresRecurringEvent = 180004
    case temporarilyNotAcceptingVerifiedServerApplications = 181000
    case allAppsMustHavePrivacyPolicy = 190001
    case allAppsMustHaveTermsOfService = 190002
    
    // Automatic moderation
    case contentBlockedByCommunityPost = 200000
    case contentBlockedByCommunitySend = 200001
    case regexValidationServiceUnavailable = 200002
    case usernameContainsBlockedContent = 200005
    
    // Guild monetization
    case monetizationRequestNotApproved = 210000
    case monetizationRequestTermsAlreadyAcked = 210001
    case cannotAccessApplication = 210002
    case monetizationTermsNotAccepted = 210003
    case twoFANotEnabled = 210011
    case monetizationRequirementsUnexpectedState = 210019
    case oldCodeRestartApp = 210020
    case cannotPublishProductWithoutBenefit = 210021
    case creatorMonetizationPaymentTeamRequired = 210026
    case mustCompletePaymentSetupVerification = 210027
    case payoutAccountNotSupportedCountry = 210028
    
    // Webhooks
    case forumWebhooksRequireThreadNameOrID = 220001
    case forumWebhooksCannotHaveBothThreadNameAndID = 220002
    case webhooksCreateThreadsOnlyInForumChannels = 220003
    case webhookServicesNotAllowedInForumChannels = 220004
    
    // Guild home
    case channelItemsCannotBeFeatured = 230000
    
    // Harmful links filter
    case messageBlockedByHarmfulLinksFilter = 240000
    
    // Drops / Quests
    case userNotEnrolledInDrop = 260000
    case userNotCompletedDrop = 260001
    case unableToClaimDropCode = 260002
    case userAlreadyClaimedDropCode = 260003
    case questDoesNotSupportCodesForPlatform = 260004
    
    // External integrations
    case consoleDevicePasscodeUnlockRequired = 270000
    case consoleDeviceUnavailable = 270001
    case consoleDeviceUnavailableFromOtherUsers = 270002
    case consoleDeviceCommunicationRestricted = 270003
    case consoleDeviceInvalidPowerMode = 270004
    case consoleDeviceAccountLinkError = 270005
    case consoleDeviceMaxMembersReached = 270006
    case consoleDeviceBadCommand = 270007
    case applicationDoesNotMeetActivityRequirements = 270008
    
    // Providers (two-way linking)
    case providerDoesNotSupportTwoWayLinking = 280000
    case userUnauthorizedToCreateProvider = 280003
    
    // Family center
    case userNotEligibleForParentTools = 290000
    case noLinkExistsBetweenUsers = 290001
    case tooManyLinksExistForOneUser = 290002
    case userLinkStatusCannotTransition = 290003
    case teensCannotRequestActivityViewInFamilyCenter = 290004
    case linkRequestAlreadyExists = 290005
    case linkingCodeNotGenerated = 290006
    case invalidOrExpiredLinkingCode = 290007
    
    // Clyde AI
    case clydeConsentRequired = 310000
    case sendingTooManyMessagesToClyde = 310002
    case unsafeBackstoryForClydeResponse = 310003
    case clydeProfileNotFound = 310006
    
    // User limitations
    case limitedAccessToGuildChannelMessages = 340001
    case limitedAccessToSendDMs = 340002
    case limitedAccessToSendGroupDMs = 340003
    case limitedAccessToSendFriendRequests = 340007
    case limitedAccessToCreateGuilds = 340009
    
    // Guild onboarding
    case cannotEnableOnboardingRequirementsNotMet = 350000
    case cannotUpdateOnboardingBelowRequirements = 350001
    
    // Summaries AI
    case serverIneligibleForSummaries = 360000
    case channelIneligibleForSummaries = 360001
    
    // Guest invites
    case cannotJoinTimeout = 380000
    
    // Emoji inventory
    case packNotFound = 390001
    case packIDRequired = 390002
    case inventoryNotEnabled = 390003
    case inventorySettingsNotEnabled = 390004
    case inventoryPackLimitReached = 390010
    case inventoryPackNoContents = 390011
    
    // Guild limitations
    case invalidToken = 400000
    case guildFileUploadRateLimitedAccess = 400001
    case guildJoinInviteLimitedAccess = 400002
    case guildGoLiveLimitedAccess = 400003
    
    // Partner promotions
    case userAlreadyClaimedPromotion = 420002
    case partnerPromotionsMaxClaims = 420003
    case giftAlreadyClaimed = 420004
    case previousPurchaseError = 420005
    case newSubscriptionRequired = 420006
    case unknownGift = 420007
    
    // Guild bans
    case failedToBanUsers = 500000
    
    // Polls / Safety hub
    case pollVotingBlocked = 520000
    case pollExpired = 520001
    case cannotCreatePollInChannelType = 520002
    case cannotEditPollMessage = 520003
    case emojiNotAllowedWithPoll = 520004
    case cannotExpireNonPollMessage = 520006
    case pollAlreadyExpired = 520007
    case dsaRSLReportNotFound = 521001
    case dsaRSLAlreadyRequested = 521002
    case dsaRSLLimitedTime = 521003
    case dsaRSLReportIneligible = 521004
    case dsaAppealRequestDeflection = 522001
    
    case generalError = 0
}

/// getting this to spit out correct pathways was a pain in the rear end
/// i spent a couple hours in a playground making it work
/// if i learnt how to use anycodable way back i probably could have saved some time
/// but its fine whats development without significant challenge
///
/// NOTE TO SELF: CHATGPT COULDN'T DEBUG YOUR FAULTY CODE BUT YOU COULD
struct DFMRestError: Decodable {
    let code: DFMRestErrorType
    let message: String
    let errors: DFMRestDynamicErrors?
    
    init(code: DFMRestErrorType, message: String) {
        self.code = code
        self.message = message
        self.errors = nil
    }
    
    struct DFMRestDynamicErrors: Decodable {
        var fieldErrors: [String: DFMErrorIssues] = [:]
        
        init(from decoder: Decoder) throws {
            let jencoder = JSONEncoder()
            let jdecoder = JSONDecoder()
            let errors = try decoder.singleValueContainer().decode([String: AnyCodable].self)
            
            for key in errors.keys {
                let data = try jencoder.encode(errors[key])
                do {
//                    let error = try JSONDecoder().decode(ErrorIssues.self, from: data)
                    let error = try jdecoder.decode(DFMErrorIssues.self, from: data)
                    fieldErrors["\(key)"] = error
                } catch {
                    let errorsA = try jdecoder.decode([String: AnyCodable].self, from: data)
                    for keyA in errorsA.keys {
                        let dataA = try jencoder.encode(errorsA[keyA])
                        do {
                            let error = try jdecoder.decode(DFMErrorIssues.self, from: dataA)
                            fieldErrors["\(key)/\(keyA)"] = error
                        } catch {
                            let errorsB = try jdecoder.decode([String: AnyCodable].self, from: dataA)
                            for keyB in errorsB.keys {
                                let dataB = try jencoder.encode(errorsB[keyB])
                                do {
                                    let error = try jdecoder.decode(DFMErrorIssues.self, from: dataB)
                                    fieldErrors["\(key)/\(keyA)/\(keyB)"] = error
                                } catch {
                                    let errorsC = try jdecoder.decode([String: AnyCodable].self, from: dataB)
                                    for keyC in errorsC.keys {
                                        let dataC = try jencoder.encode(errorsC[keyC])
                                        do {
                                            let error = try jdecoder.decode(DFMErrorIssues.self, from: dataC)
                                            fieldErrors["\(key)/\(keyA)/\(keyB)/\(keyC)"] = error
                                        } catch {
                                            let errorsD = try jdecoder.decode([String: AnyCodable].self, from: dataC)
                                            for keyD in errorsD.keys {
                                                let dataD = try jencoder.encode(errorsD[keyD])
                                                do {
                                                    let error = try jdecoder.decode(DFMErrorIssues.self, from: dataD)
                                                    fieldErrors["\(key)/\(keyA)/\(keyB)/\(keyC)/\(keyD)"] = error
                                                } catch {
                                                    // it shouldn't fall down this recursively
                                                    // if theres an edge case where it does then shrug i guess
                                                    // PR it in later
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    struct DFMErrorIssues: Decodable {
        let _errors: [DFMErrorIssuesStructure]
    }
    
    struct DFMErrorIssuesStructure: Decodable {
        let code: String
        let message: String
    }
}
