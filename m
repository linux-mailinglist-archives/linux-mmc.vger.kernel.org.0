Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E5148B392
	for <lists+linux-mmc@lfdr.de>; Tue, 11 Jan 2022 18:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244561AbiAKRSc (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 11 Jan 2022 12:18:32 -0500
Received: from mail-co1nam11on2052.outbound.protection.outlook.com ([40.107.220.52]:54241
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344444AbiAKRRS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 11 Jan 2022 12:17:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6/gt68YdoWqMbZNsSkLVDp27hdTfmQ69DgBiqx39iiLdgAnMMcE5x0sCCxLfPIrKWZI/Cp9MLOP49XGYwxyWzBXvZcJlQt37B3ZBCg+V0qQrsTFyLFCLHCo2yDBSHMgwkdKBzWa+7QsmjGE+nJtuAlBNtpC1UBebg9RardzPEdN2yO8ppIsNt0q6Skwu+nzbernL3k597mqGkekTukI2XqwATZcBGsOAM9Kipb0+tvxhVHDyPTetpDuhqBVNgxCquGb+bM/DZrS1TtpEJsB7ywAx00xhsksV0A1UKKIm/S7ay0jk/Z7C9wHDhSMzxIOpq+od6N31Nv5WWeb43oj1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8hu8Tjg/5CBLMJM4vtjrt562ygRIgZRSDIbD6lqFos=;
 b=VeNM/xEd70NCZTeKuCe0QXgI+2YeR5qqjOsBcjPCpz0PI0x0XjX/hmvUU5pHgwSIdTXJbWMo7BvQexAN+4acRqXa24Cfka4JW2I2C4GnGuHB9na2GeZGfMcD5W8Y01t/FHa6wQ3hK6VoV9pJQDggJhW9l+L1yrUnI0SVpQF2LdwJmNapTrQvecqtm28oSd5oZJmhU0rRmMpfX+IIKEMUZtWx2DiUSjIH+2OzwI/EshvIO42F8EiESk/0PIQv9RwUU9L3TMiB2m+1eV6dDJQaANRgGpDxAAlm3QdSHyfgzgF+Tkd834t+aMdswKlwvuwv+XXTJVC3KFLjcHyaWaiaiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8hu8Tjg/5CBLMJM4vtjrt562ygRIgZRSDIbD6lqFos=;
 b=jfO3Z2inDMNr7nmMn50Df0DHQQ+K+lkQMUy+JcDs/0RjoDa9KoUFOnc8Pgf+FWYryGeX1WAH19mDFe8+AcL2CFs3PJE8OOdBQzgy6gl10utK7fGZ44YgGbMCOvl0Xol8bNU182AG5TfB72JOjKE7g/FK4BSzlX7myq8nX4JNgJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 17:15:44 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::d031:da9e:71a:73e4]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::d031:da9e:71a:73e4%6]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 17:15:44 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mmc@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v9 22/24] wfx: add traces.h
Date:   Tue, 11 Jan 2022 18:14:22 +0100
Message-Id: <20220111171424.862764-23-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111171424.862764-1-Jerome.Pouiller@silabs.com>
References: <20220111171424.862764-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: SN1PR12CA0099.namprd12.prod.outlook.com
 (2603:10b6:802:21::34) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72926fe7-97f7-4454-e414-08d9d5260038
X-MS-TrafficTypeDiagnostic: PH0PR11MB5657:EE_
X-Microsoft-Antispam-PRVS: <PH0PR11MB5657D23B60314369C29CAB4893519@PH0PR11MB5657.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:66;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sU9SXH159u39f+v6SKg2TMF5dFaefCnYW36G23BWTGh34G4+Cl81lzZ1lK+bMKPMrNLdFIVlgjUBZXF1ui7+BYa9x/CowWZsHAJcrRxlXUbFp92LOQJpeq5dd6snOSvyDcxCjIa+4/ltEdlQFw5Q+USRLEA1txXS1iZfpOMLRkgWT4Cnbe8N4uJ3mkdz8HE35+JroXkzEbPueTr+9UE9WsNVgoPZLH+mjAz12xM7bjoQzmFU/TtU/eZE3IZITYmDUOxFiom7/kmKUHFSCVY9aOGf0H/wozHsNhcoifAA03UvylnyBMqZSqK/a6J5FhUNQqcd+26bSZK2hFfFdpRrE2MhUi1H/DhMLH89sVlLiiYZbFxSjw8KY+rlSm47vCN/8MES8+WuCwuPZSkpw840RKpuIpeTe7ORaChE074tjmZhkqy3bTTC5Ijb9Su69ix4hHXmN6JyJOGIO1qSHa4H8CxoGzOAV5h6cVq/KP39X0KDTNLYYKLEqrvxf+7+JyFaqqNj1dllYDkgBGVYAxnpPKJ+21CVhH3PK0SSuSSqvs2xXU9wwpKKKK7S6fvKUs9iFParLJDm17ufcS3KoX+cSrNTronFfWuDACaqyt5amxBcu1vMLNC64tQxmXXFYVOOXQKi4BWDOgNaORTN9k90hqiQuWyKzRCzQ31V3KIcAiAhL3uFEmpq3RP2i+aYgft6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(66574015)(86362001)(5660300002)(8936002)(7416002)(6916009)(8676002)(83380400001)(1076003)(6486002)(36756003)(38100700002)(186003)(66946007)(6666004)(2616005)(4326008)(2906002)(316002)(107886003)(66556008)(66476007)(54906003)(6512007)(508600001)(30864003)(52116002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bndHOW5Rekc1S0wwSjkvTkIrYU9sTE5SSi93SXpkUWhCS05IblpnS2NESG8z?=
 =?utf-8?B?WG9QQThPVlV2S2FDNlY3aVZXWEVRQjIxQ0NiQUl4WGJnSDNmSWdNNEVaTGIw?=
 =?utf-8?B?QWpRVDVCcmpndlJyM3A5dmRxV2J0ay9hM092NFMrV3YvQTZDVVlCMEU3Z3ZH?=
 =?utf-8?B?bVUvTTRYb1JLTW5uZ2R0VnFIL0V6V1hyWUZyUlVheFEzOVdxK2hvNWVZbEVh?=
 =?utf-8?B?RG5MWUZ0UUluMXQweTd1aUNXQm43SnVtTDRWc1JOMlBkZWdsRVJTTFBrZEtt?=
 =?utf-8?B?Ynl5NTVtd0xRWEFFb1ZTaU5TSTRDdGxxTllKVmdqUDh3cS96S1hzN3FJdlAy?=
 =?utf-8?B?MHdDZWNTN2Q4czZjaGE3R2FXN1dha1J4Q0FWY0tqWCtucVYybjZNamZsaW5C?=
 =?utf-8?B?MkYzVnhaSjJHcm9lVXk3VVRIKzduWTFQMGNmOHZGL092ZkVIVkV2NjlIdXIr?=
 =?utf-8?B?S09SU1lQVmpwVjhzOThhVytlSUVOZ3lTYWhCZnFxM01OYlRncmRUTDYyV25z?=
 =?utf-8?B?S09XY2RnVjVnYWF2NlFYeXBra2gwclNkdWUrMFBFanhXVHpwaGJFd3JXeHRs?=
 =?utf-8?B?aTlLZHh0MFdCYkx3UHJNMWRVbFhaTFFQa3ZkUjBremVmRGUycnJqMEpqamg2?=
 =?utf-8?B?SkI3a2trbzJCWStSWllaNzVNYkNWaDk4TWJUeU51ZDFmWkllOHlVME40anhr?=
 =?utf-8?B?N1lKbzdMTjdzRE5XMVljZzhld3FDbFpUWE44VEJGS3orUDVmcW14cCthRVIx?=
 =?utf-8?B?OE5pUWlmT0tMVkZxTjdxbVRXcWNtL1BDYjlCbTY3NXlXN01naGIwR3VGbWUv?=
 =?utf-8?B?QlNkRTFuV1pXQjYyMnJrM09QVnFFUWhGUzRtd1lObVRRdncxMnNXZHBvczFW?=
 =?utf-8?B?bzh4VDV1dllFMXgrYTFkMWNUcStYeC84Q0FvbWZuei93KzFrcThMVFZQRlA4?=
 =?utf-8?B?ejNrNE5Db2lxYnJlNXdObElxa2pmc01IM2Z1ME1vZXBIcHNIREhsSzRsTDNV?=
 =?utf-8?B?Ykg0VDJJMUFCalU3UnJWVDBKdnU3SG1GRHBDREt0REJqOFRtREhodi81MHd5?=
 =?utf-8?B?V0hRdnlZNmtucUhoUEJGaDJtNHJJV09kMGdkTHRvVHhRQzg4TC80b1lwd1dS?=
 =?utf-8?B?eVppVFNBdnZPZG1maEdRL3VuY280SnNQdVY2bnB4TWhxOWY4QnVTUlR1OGps?=
 =?utf-8?B?amJMQ0JQR1dBMjFHcXdpUE52T01lNE9RTVV0dW9PU3BtT0Y5K3F0QnFidng0?=
 =?utf-8?B?Y0JrN1NDTStRZEppTWJPYkRIeHQvei94dUhYSGJpZXBnWmtBQ3A1a1YrTFFS?=
 =?utf-8?B?MWdMY1ZqcDlHZkVJd0R2QUlGTlVPTkY4aHFVa1oxdWIzN2lIVVFxa1cwRkR2?=
 =?utf-8?B?eE9rODdHY21CSENVQ2ZEVFlhNVhxL3NZWjFZRXBMNi9YZTloaDZQTm9sRmVk?=
 =?utf-8?B?QitMZHZocDJBNEZKUXRKcVoxQ2VrM0lsV2RNTDE4SE1jcGIrVEpsWHpaSnFR?=
 =?utf-8?B?bW5yNGswWUs2SnhobjlRaDlDSlhHRCtzbVRYV1NBekhtbEJtK2hMNTg1cmIr?=
 =?utf-8?B?aFRNRGUyZXNURENXbVcyL2JyaUhHMHdURG12WUE0MWVZVDBEMlQ1dndIenI5?=
 =?utf-8?B?NnlKYlRrVy9adkNqK0VwUzJCWHZOTTNnQy9DTEhMR1lrTjlHTlo4NExtcGVy?=
 =?utf-8?B?d3FULzN4Q2JqRGhWSXJ1QmwyNC91aVVXVkNPMmNoTS9mUGQzZTJ3cURIUTMw?=
 =?utf-8?B?Tm9BR0ZmUFA3NDZXamh4NlA1UEZCbVZ3ZDlCV0liOEVWSk95eC9sNkNYa2Ev?=
 =?utf-8?B?Z1lzWFlIVFp4S2gzQnhndDNWOW1md24wdEVNcW1wR1hFSUQrTFRFdGlNdGZv?=
 =?utf-8?B?TnE1ZDNsM3RFNERqdW1yK2pKQlArT1VGRnFhVEt5cm9sKyt3WWsyY211S1JD?=
 =?utf-8?B?dkdYUXliVWJLbExtS3VjRzdUYVN0WUNaNEgraWJyUlhUcktVZnlRQVdDZEIx?=
 =?utf-8?B?ZUZOTXIyek9rMTRkTDluRTY5NnhON01NZjdycWUzeWdlTWRsWW1XRnZISmNv?=
 =?utf-8?B?OTgrT2RvRlhNRTRHOEl6aE84c3pYSGZEOVJjamVvTW5LQnVsR1EvelhWSDVm?=
 =?utf-8?B?aUxWS2RLWmNPbjA5b2FxUlFpQmN4Nm5zTzVJMEc5RHNXaWtwTHVJQXRTOEZz?=
 =?utf-8?B?TWtUbUFGQnBIaHRURmd1cVVHSmlKdDhTc0tXYm1sb2lpRzc0SVhEa3A4YjJF?=
 =?utf-8?Q?52idEfqkxPKdVnrR47bb3UpyTCSrte4Rz6RnQ8HE3Q=3D?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72926fe7-97f7-4454-e414-08d9d5260038
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 17:15:44.1024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4f+SsvUtkPnxV5zL+RSl2ovB7TcguFmWcK1VebzfxwQAM9jHYzqDADhmTTgTc6sne/hwwmS8ZOTwv4JqsBmG7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5657
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKU2ln
bmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvdHJhY2VzLmggfCA0OTYgKysr
KysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA0OTYgaW5zZXJ0aW9ucygrKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvdHJhY2Vz
LmgKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3RyYWNlcy5o
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC90cmFjZXMuaApuZXcgZmlsZSBtb2Rl
IDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLmUwMTFlOGE0NmJkNQotLS0gL2Rldi9udWxsCisr
KyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvdHJhY2VzLmgKQEAgLTAsMCArMSw0
OTYgQEAKKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkgKi8KKy8qCisg
KiBUcmFjZXBvaW50cyBkZWZpbml0aW9ucy4KKyAqCisgKiBDb3B5cmlnaHQgKGMpIDIwMTgtMjAy
MCwgU2lsaWNvbiBMYWJvcmF0b3JpZXMsIEluYy4KKyAqLworCisjdW5kZWYgVFJBQ0VfU1lTVEVN
CisjZGVmaW5lIFRSQUNFX1NZU1RFTSB3ZngKKworI2lmICFkZWZpbmVkKF9XRlhfVFJBQ0VfSCkg
fHwgZGVmaW5lZChUUkFDRV9IRUFERVJfTVVMVElfUkVBRCkKKyNkZWZpbmUgX1dGWF9UUkFDRV9I
CisKKyNpbmNsdWRlIDxsaW51eC90cmFjZXBvaW50Lmg+CisjaW5jbHVkZSA8bmV0L21hYzgwMjEx
Lmg+CisKKyNpbmNsdWRlICJidXMuaCIKKyNpbmNsdWRlICJoaWZfYXBpX2NtZC5oIgorI2luY2x1
ZGUgImhpZl9hcGlfbWliLmgiCisKKy8qIFRoZSBoZWxsIGJlbG93IG5lZWQgc29tZSBleHBsYW5h
dGlvbnMuIEZvciBlYWNoIHN5bWJvbGljIG51bWJlciwgd2UgbmVlZCB0byBkZWZpbmUgaXQgd2l0
aAorICogVFJBQ0VfREVGSU5FX0VOVU0oKSBhbmQgaW4gYSBsaXN0IGZvciBfX3ByaW50X3N5bWJv
bGljLgorICoKKyAqICAgMS4gRGVmaW5lIGEgbmV3IG1hY3JvIHRoYXQgY2FsbCBUUkFDRV9ERUZJ
TkVfRU5VTSgpOgorICoKKyAqICAgICAgICAgICNkZWZpbmUgeHh4X25hbWUoc3ltKSBUUkFDRV9E
RUZJTkVfRU5VTShzeW0pOworICoKKyAqICAgMi4gRGVmaW5lIGxpc3Qgb2YgYWxsIHN5bWJvbHM6
CisgKgorICogICAgICAgICAgI2RlZmluZSBsaXN0X25hbWVzICAgICBcCisgKiAgICAgICAgICAg
ICAuLi4gICAgICAgICAgICAgICAgIFwKKyAqICAgICAgICAgICAgIHh4eF9uYW1lKFhYWCkgICAg
ICAgXAorICogICAgICAgICAgICAgLi4uCisgKgorICogICAzLiBJbnN0YW50aWF0ZSB0aGF0IGxp
c3RfbmFtZXM6CisgKgorICogICAgICAgICAgbGlzdF9uYW1lcworICoKKyAqICAgNC4gUmVkZWZp
bmUgeHh4X25hbWUoKSBhcyBhbiBlbnRyeSBvZiBhcnJheSBmb3IgX19wcmludF9zeW1ib2xpYygp
CisgKgorICogICAgICAgICAgI3VuZGVmIHh4eF9uYW1lCisgKiAgICAgICAgICAjZGVmaW5lIHh4
eF9uYW1lKG1zZykgeyBtc2csICNtc2cgfSwKKyAqCisgKiAgIDUuIGxpc3RfbmFtZSBjYW4gbm93
IG5lYXJseSBiZSB1c2VkIHdpdGggX19wcmludF9zeW1ib2xpYygpIGJ1dCwgX19wcmludF9zeW1i
b2xpYygpIGRpc2xpa2UKKyAqICAgICAgbGFzdCBjb21tYSBvZiBsaXN0LiBTbyB3ZSBkZWZpbmUg
YSBuZXcgbGlzdCB3aXRoIGEgZHVtbXkgZWxlbWVudDoKKyAqCisgKiAgICAgICAgICAjZGVmaW5l
IGxpc3RfZm9yX3ByaW50X3N5bWJvbGljIGxpc3RfbmFtZXMgeyAtMSwgTlVMTCB9CisgKi8KKwor
I2RlZmluZSBfaGlmX21zZ19saXN0ICAgICAgICAgICAgICAgICAgICAgICBcCisJaGlmX2NuZl9u
YW1lKEFERF9LRVkpICAgICAgICAgICAgICAgXAorCWhpZl9jbmZfbmFtZShCRUFDT05fVFJBTlNN
SVQpICAgICAgIFwKKwloaWZfY25mX25hbWUoRURDQV9RVUVVRV9QQVJBTVMpICAgICBcCisJaGlm
X2NuZl9uYW1lKEpPSU4pICAgICAgICAgICAgICAgICAgXAorCWhpZl9jbmZfbmFtZShNQVBfTElO
SykgICAgICAgICAgICAgIFwKKwloaWZfY25mX25hbWUoUkVBRF9NSUIpICAgICAgICAgICAgICBc
CisJaGlmX2NuZl9uYW1lKFJFTU9WRV9LRVkpICAgICAgICAgICAgXAorCWhpZl9jbmZfbmFtZShS
RVNFVCkgICAgICAgICAgICAgICAgIFwKKwloaWZfY25mX25hbWUoU0VUX0JTU19QQVJBTVMpICAg
ICAgICBcCisJaGlmX2NuZl9uYW1lKFNFVF9QTV9NT0RFKSAgICAgICAgICAgXAorCWhpZl9jbmZf
bmFtZShTVEFSVCkgICAgICAgICAgICAgICAgIFwKKwloaWZfY25mX25hbWUoU1RBUlRfU0NBTikg
ICAgICAgICAgICBcCisJaGlmX2NuZl9uYW1lKFNUT1BfU0NBTikgICAgICAgICAgICAgXAorCWhp
Zl9jbmZfbmFtZShUWCkgICAgICAgICAgICAgICAgICAgIFwKKwloaWZfY25mX25hbWUoTVVMVElf
VFJBTlNNSVQpICAgICAgICBcCisJaGlmX2NuZl9uYW1lKFVQREFURV9JRSkgICAgICAgICAgICAg
XAorCWhpZl9jbmZfbmFtZShXUklURV9NSUIpICAgICAgICAgICAgIFwKKwloaWZfY25mX25hbWUo
Q09ORklHVVJBVElPTikgICAgICAgICBcCisJaGlmX2NuZl9uYW1lKENPTlRST0xfR1BJTykgICAg
ICAgICAgXAorCWhpZl9jbmZfbmFtZShQUkVWRU5UX1JPTExCQUNLKSAgICAgIFwKKwloaWZfY25m
X25hbWUoU0VUX1NMX01BQ19LRVkpICAgICAgICBcCisJaGlmX2NuZl9uYW1lKFNMX0NPTkZJR1VS
RSkgICAgICAgICAgXAorCWhpZl9jbmZfbmFtZShTTF9FWENIQU5HRV9QVUJfS0VZUykgIFwKKwlo
aWZfY25mX25hbWUoU0hVVF9ET1dOKSAgICAgICAgICAgICBcCisJaGlmX2luZF9uYW1lKEVWRU5U
KSAgICAgICAgICAgICAgICAgXAorCWhpZl9pbmRfbmFtZShKT0lOX0NPTVBMRVRFKSAgICAgICAg
IFwKKwloaWZfaW5kX25hbWUoUlgpICAgICAgICAgICAgICAgICAgICBcCisJaGlmX2luZF9uYW1l
KFNDQU5fQ01QTCkgICAgICAgICAgICAgXAorCWhpZl9pbmRfbmFtZShTRVRfUE1fTU9ERV9DTVBM
KSAgICAgIFwKKwloaWZfaW5kX25hbWUoU1VTUEVORF9SRVNVTUVfVFgpICAgICBcCisJaGlmX2lu
ZF9uYW1lKFNMX0VYQ0hBTkdFX1BVQl9LRVlTKSAgXAorCWhpZl9pbmRfbmFtZShFUlJPUikgICAg
ICAgICAgICAgICAgIFwKKwloaWZfaW5kX25hbWUoRVhDRVBUSU9OKSAgICAgICAgICAgICBcCisJ
aGlmX2luZF9uYW1lKEdFTkVSSUMpICAgICAgICAgICAgICAgXAorCWhpZl9pbmRfbmFtZShXQUtF
VVApICAgICAgICAgICAgICAgIFwKKwloaWZfaW5kX25hbWUoU1RBUlRVUCkKKworI2RlZmluZSBo
aWZfbXNnX2xpc3RfZW51bSBfaGlmX21zZ19saXN0CisKKyN1bmRlZiBoaWZfY25mX25hbWUKKyN1
bmRlZiBoaWZfaW5kX25hbWUKKyNkZWZpbmUgaGlmX2NuZl9uYW1lKG1zZykgVFJBQ0VfREVGSU5F
X0VOVU0oSElGX0NORl9JRF8jI21zZyk7CisjZGVmaW5lIGhpZl9pbmRfbmFtZShtc2cpIFRSQUNF
X0RFRklORV9FTlVNKEhJRl9JTkRfSURfIyNtc2cpOworaGlmX21zZ19saXN0X2VudW0KKyN1bmRl
ZiBoaWZfY25mX25hbWUKKyN1bmRlZiBoaWZfaW5kX25hbWUKKyNkZWZpbmUgaGlmX2NuZl9uYW1l
KG1zZykgeyBISUZfQ05GX0lEXyMjbXNnLCAjbXNnIH0sCisjZGVmaW5lIGhpZl9pbmRfbmFtZSht
c2cpIHsgSElGX0lORF9JRF8jI21zZywgI21zZyB9LAorI2RlZmluZSBoaWZfbXNnX2xpc3QgaGlm
X21zZ19saXN0X2VudW0geyAtMSwgTlVMTCB9CisKKyNkZWZpbmUgX2hpZl9taWJfbGlzdCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorCWhpZl9taWJfbmFtZShBUlBfSVBfQUREUkVT
U0VTX1RBQkxFKSAgICAgICAgIFwKKwloaWZfbWliX25hbWUoQVJQX0tFRVBfQUxJVkVfUEVSSU9E
KSAgICAgICAgICBcCisJaGlmX21pYl9uYW1lKEJFQUNPTl9GSUxURVJfRU5BQkxFKSAgICAgICAg
ICAgXAorCWhpZl9taWJfbmFtZShCRUFDT05fRklMVEVSX1RBQkxFKSAgICAgICAgICAgIFwKKwlo
aWZfbWliX25hbWUoQkVBQ09OX1NUQVRTKSAgICAgICAgICAgICAgICAgICBcCisJaGlmX21pYl9u
YW1lKEJFQUNPTl9XQUtFVVBfUEVSSU9EKSAgICAgICAgICAgXAorCWhpZl9taWJfbmFtZShCTE9D
S19BQ0tfUE9MSUNZKSAgICAgICAgICAgICAgIFwKKwloaWZfbWliX25hbWUoQ0NBX0NPTkZJRykg
ICAgICAgICAgICAgICAgICAgICBcCisJaGlmX21pYl9uYW1lKENPTkZJR19EQVRBX0ZJTFRFUikg
ICAgICAgICAgICAgXAorCWhpZl9taWJfbmFtZShDT1VOVEVSU19UQUJMRSkgICAgICAgICAgICAg
ICAgIFwKKwloaWZfbWliX25hbWUoQ1VSUkVOVF9UWF9QT1dFUl9MRVZFTCkgICAgICAgICBcCisJ
aGlmX21pYl9uYW1lKERPVDExX01BQ19BRERSRVNTKSAgICAgICAgICAgICAgXAorCWhpZl9taWJf
bmFtZShET1QxMV9NQVhfUkVDRUlWRV9MSUZFVElNRSkgICAgIFwKKwloaWZfbWliX25hbWUoRE9U
MTFfTUFYX1RSQU5TTUlUX01TRFVfTElGRVRJTUUpIFwKKwloaWZfbWliX25hbWUoRE9UMTFfUlRT
X1RIUkVTSE9MRCkgICAgICAgICAgICBcCisJaGlmX21pYl9uYW1lKERPVDExX1dFUF9ERUZBVUxU
X0tFWV9JRCkgICAgICAgXAorCWhpZl9taWJfbmFtZShFVEhFUlRZUEVfREFUQUZSQU1FX0NPTkRJ
VElPTikgIFwKKwloaWZfbWliX25hbWUoRVhURU5ERURfQ09VTlRFUlNfVEFCTEUpICAgICAgICBc
CisJaGlmX21pYl9uYW1lKEdMX0JMT0NLX0FDS19JTkZPKSAgICAgICAgICAgICAgXAorCWhpZl9t
aWJfbmFtZShHTF9PUEVSQVRJT05BTF9QT1dFUl9NT0RFKSAgICAgIFwKKwloaWZfbWliX25hbWUo
R0xfU0VUX01VTFRJX01TRykgICAgICAgICAgICAgICBcCisJaGlmX21pYl9uYW1lKEdSUF9TRVFf
Q09VTlRFUikgICAgICAgICAgICAgICAgXAorCWhpZl9taWJfbmFtZShJTkFDVElWSVRZX1RJTUVS
KSAgICAgICAgICAgICAgIFwKKwloaWZfbWliX25hbWUoSU5URVJGQUNFX1BST1RFQ1RJT04pICAg
ICAgICAgICBcCisJaGlmX21pYl9uYW1lKElQVjRfQUREUl9EQVRBRlJBTUVfQ09ORElUSU9OKSAg
XAorCWhpZl9taWJfbmFtZShJUFY2X0FERFJfREFUQUZSQU1FX0NPTkRJVElPTikgIFwKKwloaWZf
bWliX25hbWUoS0VFUF9BTElWRV9QRVJJT0QpICAgICAgICAgICAgICBcCisJaGlmX21pYl9uYW1l
KE1BQ19BRERSX0RBVEFGUkFNRV9DT05ESVRJT04pICAgXAorCWhpZl9taWJfbmFtZShNQUdJQ19E
QVRBRlJBTUVfQ09ORElUSU9OKSAgICAgIFwKKwloaWZfbWliX25hbWUoTUFYX1RYX1BPV0VSX0xF
VkVMKSAgICAgICAgICAgICBcCisJaGlmX21pYl9uYW1lKE5PTl9FUlBfUFJPVEVDVElPTikgICAg
ICAgICAgICAgXAorCWhpZl9taWJfbmFtZShOU19JUF9BRERSRVNTRVNfVEFCTEUpICAgICAgICAg
IFwKKwloaWZfbWliX25hbWUoT1ZFUlJJREVfSU5URVJOQUxfVFhfUkFURSkgICAgICBcCisJaGlm
X21pYl9uYW1lKFBPUlRfREFUQUZSQU1FX0NPTkRJVElPTikgICAgICAgXAorCWhpZl9taWJfbmFt
ZShQUk9URUNURURfTUdNVF9QT0xJQ1kpICAgICAgICAgIFwKKwloaWZfbWliX25hbWUoUkNQSV9S
U1NJX1RIUkVTSE9MRCkgICAgICAgICAgICBcCisJaGlmX21pYl9uYW1lKFJYX0ZJTFRFUikgICAg
ICAgICAgICAgICAgICAgICAgXAorCWhpZl9taWJfbmFtZShTRVRfQVNTT0NJQVRJT05fTU9ERSkg
ICAgICAgICAgIFwKKwloaWZfbWliX25hbWUoU0VUX0RBVEFfRklMVEVSSU5HKSAgICAgICAgICAg
ICBcCisJaGlmX21pYl9uYW1lKFNFVF9IVF9QUk9URUNUSU9OKSAgICAgICAgICAgICAgXAorCWhp
Zl9taWJfbmFtZShTRVRfVFhfUkFURV9SRVRSWV9QT0xJQ1kpICAgICAgIFwKKwloaWZfbWliX25h
bWUoU0VUX1VBUFNEX0lORk9STUFUSU9OKSAgICAgICAgICBcCisJaGlmX21pYl9uYW1lKFNMT1Rf
VElNRSkgICAgICAgICAgICAgICAgICAgICAgXAorCWhpZl9taWJfbmFtZShTVEFUSVNUSUNTX1RB
QkxFKSAgICAgICAgICAgICAgIFwKKwloaWZfbWliX25hbWUoVEVNUExBVEVfRlJBTUUpICAgICAg
ICAgICAgICAgICBcCisJaGlmX21pYl9uYW1lKFRTRl9DT1VOVEVSKSAgICAgICAgICAgICAgICAg
ICAgXAorCWhpZl9taWJfbmFtZShVQ19NQ19CQ19EQVRBRlJBTUVfQ09ORElUSU9OKQorCisjZGVm
aW5lIGhpZl9taWJfbGlzdF9lbnVtIF9oaWZfbWliX2xpc3QKKworI3VuZGVmIGhpZl9taWJfbmFt
ZQorI2RlZmluZSBoaWZfbWliX25hbWUobWliKSBUUkFDRV9ERUZJTkVfRU5VTShISUZfTUlCX0lE
XyMjbWliKTsKK2hpZl9taWJfbGlzdF9lbnVtCisjdW5kZWYgaGlmX21pYl9uYW1lCisjZGVmaW5l
IGhpZl9taWJfbmFtZShtaWIpIHsgSElGX01JQl9JRF8jI21pYiwgI21pYiB9LAorI2RlZmluZSBo
aWZfbWliX2xpc3QgaGlmX21pYl9saXN0X2VudW0geyAtMSwgTlVMTCB9CisKK0RFQ0xBUkVfRVZF
TlRfQ0xBU1MoaGlmX2RhdGEsCisJVFBfUFJPVE8oY29uc3Qgc3RydWN0IHdmeF9oaWZfbXNnICpo
aWYsIGludCB0eF9maWxsX2xldmVsLCBib29sIGlzX3JlY3YpLAorCVRQX0FSR1MoaGlmLCB0eF9m
aWxsX2xldmVsLCBpc19yZWN2KSwKKwlUUF9TVFJVQ1RfX2VudHJ5KAorCQlfX2ZpZWxkKGludCwg
dHhfZmlsbF9sZXZlbCkKKwkJX19maWVsZChpbnQsIG1zZ19pZCkKKwkJX19maWVsZChjb25zdCBj
aGFyICosIG1zZ190eXBlKQorCQlfX2ZpZWxkKGludCwgbXNnX2xlbikKKwkJX19maWVsZChpbnQs
IGJ1Zl9sZW4pCisJCV9fZmllbGQoaW50LCBpZl9pZCkKKwkJX19maWVsZChpbnQsIG1pYikKKwkJ
X19hcnJheSh1OCwgYnVmLCAxMjgpCisJKSwKKwlUUF9mYXN0X2Fzc2lnbigKKwkJaW50IGhlYWRl
cl9sZW47CisKKwkJX19lbnRyeS0+dHhfZmlsbF9sZXZlbCA9IHR4X2ZpbGxfbGV2ZWw7CisJCV9f
ZW50cnktPm1zZ19sZW4gPSBsZTE2X3RvX2NwdShoaWYtPmxlbik7CisJCV9fZW50cnktPm1zZ19p
ZCA9IGhpZi0+aWQ7CisJCV9fZW50cnktPmlmX2lkID0gaGlmLT5pbnRlcmZhY2U7CisJCWlmIChp
c19yZWN2KQorCQkJX19lbnRyeS0+bXNnX3R5cGUgPSBfX2VudHJ5LT5tc2dfaWQgJiAweDgwID8g
IklORCIgOiAiQ05GIjsKKwkJZWxzZQorCQkJX19lbnRyeS0+bXNnX3R5cGUgPSAiUkVRIjsKKwkJ
aWYgKCFpc19yZWN2ICYmCisJCSAgICAoX19lbnRyeS0+bXNnX2lkID09IEhJRl9SRVFfSURfUkVB
RF9NSUIgfHwKKwkJICAgICBfX2VudHJ5LT5tc2dfaWQgPT0gSElGX1JFUV9JRF9XUklURV9NSUIp
KSB7CisJCQlfX2VudHJ5LT5taWIgPSBsZTE2X3RvX2NwdXAoKF9fbGUxNiAqKWhpZi0+Ym9keSk7
CisJCQloZWFkZXJfbGVuID0gNDsKKwkJfSBlbHNlIHsKKwkJCV9fZW50cnktPm1pYiA9IC0xOwor
CQkJaGVhZGVyX2xlbiA9IDA7CisJCX0KKwkJX19lbnRyeS0+YnVmX2xlbiA9IG1pbl90KGludCwg
X19lbnRyeS0+bXNnX2xlbiwgc2l6ZW9mKF9fZW50cnktPmJ1ZikpCisJCQkJICAgLSBzaXplb2Yo
c3RydWN0IHdmeF9oaWZfbXNnKSAtIGhlYWRlcl9sZW47CisJCW1lbWNweShfX2VudHJ5LT5idWYs
IGhpZi0+Ym9keSArIGhlYWRlcl9sZW4sIF9fZW50cnktPmJ1Zl9sZW4pOworCSksCisJVFBfcHJp
bnRrKCIlZDolZDolc18lcyVzJXM6ICVzJXMgKCVkIGJ5dGVzKSIsCisJCV9fZW50cnktPnR4X2Zp
bGxfbGV2ZWwsCisJCV9fZW50cnktPmlmX2lkLAorCQlfX2VudHJ5LT5tc2dfdHlwZSwKKwkJX19w
cmludF9zeW1ib2xpYyhfX2VudHJ5LT5tc2dfaWQsIGhpZl9tc2dfbGlzdCksCisJCV9fZW50cnkt
Pm1pYiAhPSAtMSA/ICIvIiA6ICIiLAorCQlfX2VudHJ5LT5taWIgIT0gLTEgPyBfX3ByaW50X3N5
bWJvbGljKF9fZW50cnktPm1pYiwgaGlmX21pYl9saXN0KSA6ICIiLAorCQlfX3ByaW50X2hleChf
X2VudHJ5LT5idWYsIF9fZW50cnktPmJ1Zl9sZW4pLAorCQlfX2VudHJ5LT5tc2dfbGVuID4gc2l6
ZW9mKF9fZW50cnktPmJ1ZikgPyAiIC4uLiIgOiAiIiwKKwkJX19lbnRyeS0+bXNnX2xlbgorCSkK
Kyk7CitERUZJTkVfRVZFTlQoaGlmX2RhdGEsIGhpZl9zZW5kLAorCVRQX1BST1RPKGNvbnN0IHN0
cnVjdCB3ZnhfaGlmX21zZyAqaGlmLCBpbnQgdHhfZmlsbF9sZXZlbCwgYm9vbCBpc19yZWN2KSwK
KwlUUF9BUkdTKGhpZiwgdHhfZmlsbF9sZXZlbCwgaXNfcmVjdikpOworI2RlZmluZSBfdHJhY2Vf
aGlmX3NlbmQoaGlmLCB0eF9maWxsX2xldmVsKVwKKwl0cmFjZV9oaWZfc2VuZChoaWYsIHR4X2Zp
bGxfbGV2ZWwsIGZhbHNlKQorREVGSU5FX0VWRU5UKGhpZl9kYXRhLCBoaWZfcmVjdiwKKwlUUF9Q
Uk9UTyhjb25zdCBzdHJ1Y3Qgd2Z4X2hpZl9tc2cgKmhpZiwgaW50IHR4X2ZpbGxfbGV2ZWwsIGJv
b2wgaXNfcmVjdiksCisJVFBfQVJHUyhoaWYsIHR4X2ZpbGxfbGV2ZWwsIGlzX3JlY3YpKTsKKyNk
ZWZpbmUgX3RyYWNlX2hpZl9yZWN2KGhpZiwgdHhfZmlsbF9sZXZlbClcCisJdHJhY2VfaGlmX3Jl
Y3YoaGlmLCB0eF9maWxsX2xldmVsLCB0cnVlKQorCisjZGVmaW5lIHdmeF9yZWdfbGlzdF9lbnVt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorCXdmeF9yZWdfbmFtZShXRlhfUkVH
X0NPTkZJRywgICAgICAgIkNPTkZJRyIpICAgICAgXAorCXdmeF9yZWdfbmFtZShXRlhfUkVHX0NP
TlRST0wsICAgICAgIkNPTlRST0wiKSAgICAgXAorCXdmeF9yZWdfbmFtZShXRlhfUkVHX0lOX09V
VF9RVUVVRSwgIlFVRVVFIikgICAgICAgXAorCXdmeF9yZWdfbmFtZShXRlhfUkVHX0FIQl9EUE9S
VCwgICAgIkFIQiIpICAgICAgICAgXAorCXdmeF9yZWdfbmFtZShXRlhfUkVHX0JBU0VfQUREUiwg
ICAgIkJBU0VfQUREUiIpICAgXAorCXdmeF9yZWdfbmFtZShXRlhfUkVHX1NSQU1fRFBPUlQsICAg
IlNSQU0iKSAgICAgICAgXAorCXdmeF9yZWdfbmFtZShXRlhfUkVHX1NFVF9HRU5fUl9XLCAgIlNF
VF9HRU5fUl9XIikgXAorCXdmeF9yZWdfbmFtZShXRlhfUkVHX0ZSQU1FX09VVCwgICAgIkZSQU1F
X09VVCIpCisKKyN1bmRlZiB3ZnhfcmVnX25hbWUKKyNkZWZpbmUgd2Z4X3JlZ19uYW1lKHN5bSwg
bmFtZSkgVFJBQ0VfREVGSU5FX0VOVU0oc3ltKTsKK3dmeF9yZWdfbGlzdF9lbnVtCisjdW5kZWYg
d2Z4X3JlZ19uYW1lCisjZGVmaW5lIHdmeF9yZWdfbmFtZShzeW0sIG5hbWUpIHsgc3ltLCBuYW1l
IH0sCisjZGVmaW5lIHdmeF9yZWdfbGlzdCB3ZnhfcmVnX2xpc3RfZW51bSB7IC0xLCBOVUxMIH0K
KworREVDTEFSRV9FVkVOVF9DTEFTUyhpb19kYXRhLAorCVRQX1BST1RPKGludCByZWcsIGludCBh
ZGRyLCBjb25zdCB2b2lkICppb19idWYsIHNpemVfdCBsZW4pLAorCVRQX0FSR1MocmVnLCBhZGRy
LCBpb19idWYsIGxlbiksCisJVFBfU1RSVUNUX19lbnRyeSgKKwkJX19maWVsZChpbnQsIHJlZykK
KwkJX19maWVsZChpbnQsIGFkZHIpCisJCV9fZmllbGQoaW50LCBtc2dfbGVuKQorCQlfX2ZpZWxk
KGludCwgYnVmX2xlbikKKwkJX19hcnJheSh1OCwgYnVmLCAzMikKKwkJX19hcnJheSh1OCwgYWRk
cl9zdHIsIDEwKQorCSksCisJVFBfZmFzdF9hc3NpZ24oCisJCV9fZW50cnktPnJlZyA9IHJlZzsK
KwkJX19lbnRyeS0+YWRkciA9IGFkZHI7CisJCV9fZW50cnktPm1zZ19sZW4gPSBsZW47CisJCV9f
ZW50cnktPmJ1Zl9sZW4gPSBtaW5fdChpbnQsIHNpemVvZihfX2VudHJ5LT5idWYpLCBfX2VudHJ5
LT5tc2dfbGVuKTsKKwkJbWVtY3B5KF9fZW50cnktPmJ1ZiwgaW9fYnVmLCBfX2VudHJ5LT5idWZf
bGVuKTsKKwkJaWYgKGFkZHIgPj0gMCkKKwkJCXNucHJpbnRmKF9fZW50cnktPmFkZHJfc3RyLCAx
MCwgIi8lMDh4IiwgYWRkcik7CisJCWVsc2UKKwkJCV9fZW50cnktPmFkZHJfc3RyWzBdID0gMDsK
KwkpLAorCVRQX3ByaW50aygiJXMlczogJXMlcyAoJWQgYnl0ZXMpIiwKKwkJX19wcmludF9zeW1i
b2xpYyhfX2VudHJ5LT5yZWcsIHdmeF9yZWdfbGlzdCksCisJCV9fZW50cnktPmFkZHJfc3RyLAor
CQlfX3ByaW50X2hleChfX2VudHJ5LT5idWYsIF9fZW50cnktPmJ1Zl9sZW4pLAorCQlfX2VudHJ5
LT5tc2dfbGVuID4gc2l6ZW9mKF9fZW50cnktPmJ1ZikgPyAiIC4uLiIgOiAiIiwKKwkJX19lbnRy
eS0+bXNnX2xlbgorCSkKKyk7CitERUZJTkVfRVZFTlQoaW9fZGF0YSwgaW9fd3JpdGUsCisJVFBf
UFJPVE8oaW50IHJlZywgaW50IGFkZHIsIGNvbnN0IHZvaWQgKmlvX2J1Ziwgc2l6ZV90IGxlbiks
CisJVFBfQVJHUyhyZWcsIGFkZHIsIGlvX2J1ZiwgbGVuKSk7CisjZGVmaW5lIF90cmFjZV9pb19p
bmRfd3JpdGUocmVnLCBhZGRyLCBpb19idWYsIGxlbilcCisJdHJhY2VfaW9fd3JpdGUocmVnLCBh
ZGRyLCBpb19idWYsIGxlbikKKyNkZWZpbmUgX3RyYWNlX2lvX3dyaXRlKHJlZywgaW9fYnVmLCBs
ZW4pIHRyYWNlX2lvX3dyaXRlKHJlZywgLTEsIGlvX2J1ZiwgbGVuKQorREVGSU5FX0VWRU5UKGlv
X2RhdGEsIGlvX3JlYWQsCisJVFBfUFJPVE8oaW50IHJlZywgaW50IGFkZHIsIGNvbnN0IHZvaWQg
KmlvX2J1Ziwgc2l6ZV90IGxlbiksCisJVFBfQVJHUyhyZWcsIGFkZHIsIGlvX2J1ZiwgbGVuKSk7
CisjZGVmaW5lIF90cmFjZV9pb19pbmRfcmVhZChyZWcsIGFkZHIsIGlvX2J1ZiwgbGVuKVwKKwl0
cmFjZV9pb19yZWFkKHJlZywgYWRkciwgaW9fYnVmLCBsZW4pCisjZGVmaW5lIF90cmFjZV9pb19y
ZWFkKHJlZywgaW9fYnVmLCBsZW4pIHRyYWNlX2lvX3JlYWQocmVnLCAtMSwgaW9fYnVmLCBsZW4p
CisKK0RFQ0xBUkVfRVZFTlRfQ0xBU1MoaW9fZGF0YTMyLAorCVRQX1BST1RPKGludCByZWcsIGlu
dCBhZGRyLCB1MzIgdmFsKSwKKwlUUF9BUkdTKHJlZywgYWRkciwgdmFsKSwKKwlUUF9TVFJVQ1Rf
X2VudHJ5KAorCQlfX2ZpZWxkKGludCwgcmVnKQorCQlfX2ZpZWxkKGludCwgYWRkcikKKwkJX19m
aWVsZChpbnQsIHZhbCkKKwkJX19hcnJheSh1OCwgYWRkcl9zdHIsIDEwKQorCSksCisJVFBfZmFz
dF9hc3NpZ24oCisJCV9fZW50cnktPnJlZyA9IHJlZzsKKwkJX19lbnRyeS0+YWRkciA9IGFkZHI7
CisJCV9fZW50cnktPnZhbCA9IHZhbDsKKwkJaWYgKGFkZHIgPj0gMCkKKwkJCXNucHJpbnRmKF9f
ZW50cnktPmFkZHJfc3RyLCAxMCwgIi8lMDh4IiwgYWRkcik7CisJCWVsc2UKKwkJCV9fZW50cnkt
PmFkZHJfc3RyWzBdID0gMDsKKwkpLAorCVRQX3ByaW50aygiJXMlczogJTA4eCIsCisJCV9fcHJp
bnRfc3ltYm9saWMoX19lbnRyeS0+cmVnLCB3ZnhfcmVnX2xpc3QpLAorCQlfX2VudHJ5LT5hZGRy
X3N0ciwKKwkJX19lbnRyeS0+dmFsCisJKQorKTsKK0RFRklORV9FVkVOVChpb19kYXRhMzIsIGlv
X3dyaXRlMzIsCisJVFBfUFJPVE8oaW50IHJlZywgaW50IGFkZHIsIHUzMiB2YWwpLAorCVRQX0FS
R1MocmVnLCBhZGRyLCB2YWwpKTsKKyNkZWZpbmUgX3RyYWNlX2lvX2luZF93cml0ZTMyKHJlZywg
YWRkciwgdmFsKSB0cmFjZV9pb193cml0ZTMyKHJlZywgYWRkciwgdmFsKQorI2RlZmluZSBfdHJh
Y2VfaW9fd3JpdGUzMihyZWcsIHZhbCkgdHJhY2VfaW9fd3JpdGUzMihyZWcsIC0xLCB2YWwpCitE
RUZJTkVfRVZFTlQoaW9fZGF0YTMyLCBpb19yZWFkMzIsCisJVFBfUFJPVE8oaW50IHJlZywgaW50
IGFkZHIsIHUzMiB2YWwpLAorCVRQX0FSR1MocmVnLCBhZGRyLCB2YWwpKTsKKyNkZWZpbmUgX3Ry
YWNlX2lvX2luZF9yZWFkMzIocmVnLCBhZGRyLCB2YWwpIHRyYWNlX2lvX3JlYWQzMihyZWcsIGFk
ZHIsIHZhbCkKKyNkZWZpbmUgX3RyYWNlX2lvX3JlYWQzMihyZWcsIHZhbCkgdHJhY2VfaW9fcmVh
ZDMyKHJlZywgLTEsIHZhbCkKKworREVDTEFSRV9FVkVOVF9DTEFTUyhwaWdneWJhY2ssCisJVFBf
UFJPVE8odTMyIHZhbCwgYm9vbCBpZ25vcmVkKSwKKwlUUF9BUkdTKHZhbCwgaWdub3JlZCksCisJ
VFBfU1RSVUNUX19lbnRyeSgKKwkJX19maWVsZChpbnQsIHZhbCkKKwkJX19maWVsZChib29sLCBp
Z25vcmVkKQorCSksCisJVFBfZmFzdF9hc3NpZ24oCisJCV9fZW50cnktPnZhbCA9IHZhbDsKKwkJ
X19lbnRyeS0+aWdub3JlZCA9IGlnbm9yZWQ7CisJKSwKKwlUUF9wcmludGsoIkNPTlRST0w6ICUw
OHglcyIsCisJCV9fZW50cnktPnZhbCwKKwkJX19lbnRyeS0+aWdub3JlZCA/ICIgKGlnbm9yZWQp
IiA6ICIiCisJKQorKTsKK0RFRklORV9FVkVOVChwaWdneWJhY2ssIHBpZ2d5YmFjaywKKwlUUF9Q
Uk9UTyh1MzIgdmFsLCBib29sIGlnbm9yZWQpLAorCVRQX0FSR1ModmFsLCBpZ25vcmVkKSk7Cisj
ZGVmaW5lIF90cmFjZV9waWdneWJhY2sodmFsLCBpZ25vcmVkKSB0cmFjZV9waWdneWJhY2sodmFs
LCBpZ25vcmVkKQorCitUUkFDRV9FVkVOVChiaF9zdGF0cywKKwlUUF9QUk9UTyhpbnQgaW5kLCBp
bnQgcmVxLCBpbnQgY25mLCBpbnQgYnVzeSwgYm9vbCByZWxlYXNlKSwKKwlUUF9BUkdTKGluZCwg
cmVxLCBjbmYsIGJ1c3ksIHJlbGVhc2UpLAorCVRQX1NUUlVDVF9fZW50cnkoCisJCV9fZmllbGQo
aW50LCBpbmQpCisJCV9fZmllbGQoaW50LCByZXEpCisJCV9fZmllbGQoaW50LCBjbmYpCisJCV9f
ZmllbGQoaW50LCBidXN5KQorCQlfX2ZpZWxkKGJvb2wsIHJlbGVhc2UpCisJKSwKKwlUUF9mYXN0
X2Fzc2lnbigKKwkJX19lbnRyeS0+aW5kID0gaW5kOworCQlfX2VudHJ5LT5yZXEgPSByZXE7CisJ
CV9fZW50cnktPmNuZiA9IGNuZjsKKwkJX19lbnRyeS0+YnVzeSA9IGJ1c3k7CisJCV9fZW50cnkt
PnJlbGVhc2UgPSByZWxlYXNlOworCSksCisJVFBfcHJpbnRrKCJJTkQvUkVRL0NORjolM2QvJTNk
LyUzZCwgUkVRIGluIHByb2dyZXNzOiUzZCwgV1VQOiAlcyIsCisJCV9fZW50cnktPmluZCwKKwkJ
X19lbnRyeS0+cmVxLAorCQlfX2VudHJ5LT5jbmYsCisJCV9fZW50cnktPmJ1c3ksCisJCV9fZW50
cnktPnJlbGVhc2UgPyAicmVsZWFzZSIgOiAia2VlcCIKKwkpCispOworI2RlZmluZSBfdHJhY2Vf
Ymhfc3RhdHMoaW5kLCByZXEsIGNuZiwgYnVzeSwgcmVsZWFzZSlcCisJdHJhY2VfYmhfc3RhdHMo
aW5kLCByZXEsIGNuZiwgYnVzeSwgcmVsZWFzZSkKKworVFJBQ0VfRVZFTlQodHhfc3RhdHMsCisJ
VFBfUFJPVE8oY29uc3Qgc3RydWN0IHdmeF9oaWZfY25mX3R4ICp0eF9jbmYsIGNvbnN0IHN0cnVj
dCBza19idWZmICpza2IsCisJCSBpbnQgZGVsYXkpLAorCVRQX0FSR1ModHhfY25mLCBza2IsIGRl
bGF5KSwKKwlUUF9TVFJVQ1RfX2VudHJ5KAorCQlfX2ZpZWxkKGludCwgcGt0X2lkKQorCQlfX2Zp
ZWxkKGludCwgZGVsYXlfbWVkaWEpCisJCV9fZmllbGQoaW50LCBkZWxheV9xdWV1ZSkKKwkJX19m
aWVsZChpbnQsIGRlbGF5X2Z3KQorCQlfX2ZpZWxkKGludCwgYWNrX2ZhaWx1cmVzKQorCQlfX2Zp
ZWxkKGludCwgZmxhZ3MpCisJCV9fYXJyYXkoaW50LCByYXRlLCA0KQorCQlfX2FycmF5KGludCwg
dHhfY291bnQsIDQpCisJKSwKKwlUUF9mYXN0X2Fzc2lnbigKKwkJLyogS2VlcCBzeW5jIHdpdGgg
d2Z4X3JhdGVzIGRlZmluaXRpb24gaW4gbWFpbi5jICovCisJCXN0YXRpYyBjb25zdCBpbnQgaHdf
cmF0ZVtdID0geyAwLCAxLCAyLCAzLCA2LCA3LCA4LCA5LCAxMCwgMTEsIDEyLCAxMyB9OworCQlj
b25zdCBzdHJ1Y3QgaWVlZTgwMjExX3R4X2luZm8gKnR4X2luZm8gPQorCQkJKGNvbnN0IHN0cnVj
dCBpZWVlODAyMTFfdHhfaW5mbyAqKXNrYi0+Y2I7CisJCWNvbnN0IHN0cnVjdCBpZWVlODAyMTFf
dHhfcmF0ZSAqcmF0ZXMgPSB0eF9pbmZvLT5kcml2ZXJfcmF0ZXM7CisJCWludCBpOworCisJCV9f
ZW50cnktPnBrdF9pZCA9IHR4X2NuZi0+cGFja2V0X2lkOworCQlfX2VudHJ5LT5kZWxheV9tZWRp
YSA9IGxlMzJfdG9fY3B1KHR4X2NuZi0+bWVkaWFfZGVsYXkpOworCQlfX2VudHJ5LT5kZWxheV9x
dWV1ZSA9IGxlMzJfdG9fY3B1KHR4X2NuZi0+dHhfcXVldWVfZGVsYXkpOworCQlfX2VudHJ5LT5k
ZWxheV9mdyA9IGRlbGF5OworCQlfX2VudHJ5LT5hY2tfZmFpbHVyZXMgPSB0eF9jbmYtPmFja19m
YWlsdXJlczsKKwkJaWYgKCF0eF9jbmYtPnN0YXR1cyB8fCBfX2VudHJ5LT5hY2tfZmFpbHVyZXMp
CisJCQlfX2VudHJ5LT5hY2tfZmFpbHVyZXMgKz0gMTsKKworCQlmb3IgKGkgPSAwOyBpIDwgSUVF
RTgwMjExX05VTV9BQ1M7IGkrKykgeworCQkJaWYgKHJhdGVzWzBdLmZsYWdzICYgSUVFRTgwMjEx
X1RYX1JDX01DUykKKwkJCQlfX2VudHJ5LT5yYXRlW2ldID0gcmF0ZXNbaV0uaWR4OworCQkJZWxz
ZQorCQkJCV9fZW50cnktPnJhdGVbaV0gPSBod19yYXRlW3JhdGVzW2ldLmlkeF07CisJCQlfX2Vu
dHJ5LT50eF9jb3VudFtpXSA9IHJhdGVzW2ldLmNvdW50OworCQl9CisJCV9fZW50cnktPmZsYWdz
ID0gMDsKKwkJaWYgKHJhdGVzWzBdLmZsYWdzICYgSUVFRTgwMjExX1RYX1JDX01DUykKKwkJCV9f
ZW50cnktPmZsYWdzIHw9IDB4MDE7CisJCWlmIChyYXRlc1swXS5mbGFncyAmIElFRUU4MDIxMV9U
WF9SQ19TSE9SVF9HSSkKKwkJCV9fZW50cnktPmZsYWdzIHw9IDB4MDI7CisJCWlmIChyYXRlc1sw
XS5mbGFncyAmIElFRUU4MDIxMV9UWF9SQ19HUkVFTl9GSUVMRCkKKwkJCV9fZW50cnktPmZsYWdz
IHw9IDB4MDQ7CisJCWlmIChyYXRlc1swXS5mbGFncyAmIElFRUU4MDIxMV9UWF9SQ19VU0VfUlRT
X0NUUykKKwkJCV9fZW50cnktPmZsYWdzIHw9IDB4MDg7CisJCWlmICh0eF9pbmZvLT5mbGFncyAm
IElFRUU4MDIxMV9UWF9DVExfU0VORF9BRlRFUl9EVElNKQorCQkJX19lbnRyeS0+ZmxhZ3MgfD0g
MHgxMDsKKwkJaWYgKHR4X2NuZi0+c3RhdHVzKQorCQkJX19lbnRyeS0+ZmxhZ3MgfD0gMHgyMDsK
KwkJaWYgKHR4X2NuZi0+c3RhdHVzID09IEhJRl9TVEFUVVNfVFhfRkFJTF9SRVFVRVVFKQorCQkJ
X19lbnRyeS0+ZmxhZ3MgfD0gMHg0MDsKKwkpLAorCVRQX3ByaW50aygicGFja2V0IElEOiAlMDh4
LCByYXRlIHBvbGljeTogJXMgJWR8JWQgJWR8JWQgJWR8JWQgJWR8JWQgLT4gJWQgYXR0ZW1wdCwg
RGVsYXlzIG1lZGlhL3F1ZXVlL3RvdGFsOiAlNGR1cy8lNGR1cy8lNGR1cyIsCisJCV9fZW50cnkt
PnBrdF9pZCwKKwkJX19wcmludF9mbGFncyhfX2VudHJ5LT5mbGFncywgTlVMTCwKKwkJCXsgMHgw
MSwgIk0iIH0sIHsgMHgwMiwgIlMiIH0sIHsgMHgwNCwgIkciIH0sIHsgMHgwOCwgIlIiIH0sCisJ
CQl7IDB4MTAsICJEIiB9LCB7IDB4MjAsICJGIiB9LCB7IDB4NDAsICJRIiB9KSwKKwkJX19lbnRy
eS0+cmF0ZVswXSwKKwkJX19lbnRyeS0+dHhfY291bnRbMF0sCisJCV9fZW50cnktPnJhdGVbMV0s
CisJCV9fZW50cnktPnR4X2NvdW50WzFdLAorCQlfX2VudHJ5LT5yYXRlWzJdLAorCQlfX2VudHJ5
LT50eF9jb3VudFsyXSwKKwkJX19lbnRyeS0+cmF0ZVszXSwKKwkJX19lbnRyeS0+dHhfY291bnRb
M10sCisJCV9fZW50cnktPmFja19mYWlsdXJlcywKKwkJX19lbnRyeS0+ZGVsYXlfbWVkaWEsCisJ
CV9fZW50cnktPmRlbGF5X3F1ZXVlLAorCQlfX2VudHJ5LT5kZWxheV9mdworCSkKKyk7CisjZGVm
aW5lIF90cmFjZV90eF9zdGF0cyh0eF9jbmYsIHNrYiwgZGVsYXkpIHRyYWNlX3R4X3N0YXRzKHR4
X2NuZiwgc2tiLCBkZWxheSkKKworVFJBQ0VfRVZFTlQocXVldWVzX3N0YXRzLAorCVRQX1BST1RP
KHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBjb25zdCBzdHJ1Y3Qgd2Z4X3F1ZXVlICplbGVjdGVkX3F1
ZXVlKSwKKwlUUF9BUkdTKHdkZXYsIGVsZWN0ZWRfcXVldWUpLAorCVRQX1NUUlVDVF9fZW50cnko
CisJCV9fZmllbGQoaW50LCB2aWZfaWQpCisJCV9fZmllbGQoaW50LCBxdWV1ZV9pZCkKKwkJX19h
cnJheShpbnQsIGh3LCBJRUVFODAyMTFfTlVNX0FDUyAqIDIpCisJCV9fYXJyYXkoaW50LCBkcnYs
IElFRUU4MDIxMV9OVU1fQUNTICogMikKKwkJX19hcnJheShpbnQsIGNhYiwgSUVFRTgwMjExX05V
TV9BQ1MgKiAyKQorCSksCisJVFBfZmFzdF9hc3NpZ24oCisJCWNvbnN0IHN0cnVjdCB3ZnhfcXVl
dWUgKnF1ZXVlOworCQlzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZjsKKwkJaW50IGksIGo7CisKKwkJZm9y
IChqID0gMDsgaiA8IElFRUU4MDIxMV9OVU1fQUNTICogMjsgaisrKSB7CisJCQlfX2VudHJ5LT5o
d1tqXSA9IC0xOworCQkJX19lbnRyeS0+ZHJ2W2pdID0gLTE7CisJCQlfX2VudHJ5LT5jYWJbal0g
PSAtMTsKKwkJfQorCQlfX2VudHJ5LT52aWZfaWQgPSAtMTsKKwkJX19lbnRyeS0+cXVldWVfaWQg
PSAtMTsKKwkJd3ZpZiA9IE5VTEw7CisJCXdoaWxlICgod3ZpZiA9IHd2aWZfaXRlcmF0ZSh3ZGV2
LCB3dmlmKSkgIT0gTlVMTCkgeworCQkJZm9yIChpID0gMDsgaSA8IElFRUU4MDIxMV9OVU1fQUNT
OyBpKyspIHsKKwkJCQlqID0gd3ZpZi0+aWQgKiBJRUVFODAyMTFfTlVNX0FDUyArIGk7CisJCQkJ
V0FSTl9PTihqID49IElFRUU4MDIxMV9OVU1fQUNTICogMik7CisJCQkJcXVldWUgPSAmd3ZpZi0+
dHhfcXVldWVbaV07CisJCQkJX19lbnRyeS0+aHdbal0gPSBhdG9taWNfcmVhZCgmcXVldWUtPnBl
bmRpbmdfZnJhbWVzKTsKKwkJCQlfX2VudHJ5LT5kcnZbal0gPSBza2JfcXVldWVfbGVuKCZxdWV1
ZS0+bm9ybWFsKTsKKwkJCQlfX2VudHJ5LT5jYWJbal0gPSBza2JfcXVldWVfbGVuKCZxdWV1ZS0+
Y2FiKTsKKwkJCQlpZiAocXVldWUgPT0gZWxlY3RlZF9xdWV1ZSkgeworCQkJCQlfX2VudHJ5LT52
aWZfaWQgPSB3dmlmLT5pZDsKKwkJCQkJX19lbnRyeS0+cXVldWVfaWQgPSBpOworCQkJCX0KKwkJ
CX0KKwkJfQorCSksCisJVFBfcHJpbnRrKCJnb3Qgc2tiIGZyb20gJWQvJWQsIHBlbmQuIGh3L25v
cm0vY2FiOiBbICVkLyVkLyVkICVkLyVkLyVkICVkLyVkLyVkICVkLyVkLyVkIF0gWyAlZC8lZC8l
ZCAlZC8lZC8lZCAlZC8lZC8lZCAlZC8lZC8lZCBdIiwKKwkJX19lbnRyeS0+dmlmX2lkLCBfX2Vu
dHJ5LT5xdWV1ZV9pZCwKKwkJX19lbnRyeS0+aHdbMF0sIF9fZW50cnktPmRydlswXSwgX19lbnRy
eS0+Y2FiWzBdLAorCQlfX2VudHJ5LT5od1sxXSwgX19lbnRyeS0+ZHJ2WzFdLCBfX2VudHJ5LT5j
YWJbMV0sCisJCV9fZW50cnktPmh3WzJdLCBfX2VudHJ5LT5kcnZbMl0sIF9fZW50cnktPmNhYlsy
XSwKKwkJX19lbnRyeS0+aHdbM10sIF9fZW50cnktPmRydlszXSwgX19lbnRyeS0+Y2FiWzNdLAor
CQlfX2VudHJ5LT5od1s0XSwgX19lbnRyeS0+ZHJ2WzRdLCBfX2VudHJ5LT5jYWJbNF0sCisJCV9f
ZW50cnktPmh3WzVdLCBfX2VudHJ5LT5kcnZbNV0sIF9fZW50cnktPmNhYls1XSwKKwkJX19lbnRy
eS0+aHdbNl0sIF9fZW50cnktPmRydls2XSwgX19lbnRyeS0+Y2FiWzZdLAorCQlfX2VudHJ5LT5o
d1s3XSwgX19lbnRyeS0+ZHJ2WzddLCBfX2VudHJ5LT5jYWJbN10KKwkpCispOworCisjZW5kaWYK
KworLyogVGhpcyBwYXJ0IG11c3QgYmUgb3V0c2lkZSBwcm90ZWN0aW9uICovCisjdW5kZWYgVFJB
Q0VfSU5DTFVERV9QQVRICisjZGVmaW5lIFRSQUNFX0lOQ0xVREVfUEFUSCAuCisjdW5kZWYgVFJB
Q0VfSU5DTFVERV9GSUxFCisjZGVmaW5lIFRSQUNFX0lOQ0xVREVfRklMRSB0cmFjZXMKKworI2lu
Y2x1ZGUgPHRyYWNlL2RlZmluZV90cmFjZS5oPgotLSAKMi4zNC4xCgo=
