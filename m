Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590D52872DF
	for <lists+linux-mmc@lfdr.de>; Thu,  8 Oct 2020 12:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgJHKy4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 8 Oct 2020 06:54:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:61191 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgJHKy4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Oct 2020 06:54:56 -0400
IronPort-SDR: RP6Sn/pDvFmMeQBLK6yupixt6M3NU0f3Txg8zmx78ujlvH7TJSKUJDhh9ItASNn+pnkGAR2zu6
 fWXtUjC0qmnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="164527645"
X-IronPort-AV: E=Sophos;i="5.77,350,1596524400"; 
   d="scan'208";a="164527645"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 03:54:55 -0700
IronPort-SDR: hMd5S/dA/RfV49Qw6dMXsR9PEGTCwPIHhQ0zr8+VKlT2joKwrn6qeecaQUjO2d7Bvh0XEqtoFQ
 L87/uNIk3xGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,350,1596524400"; 
   d="scan'208";a="349452903"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 08 Oct 2020 03:54:54 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 8 Oct 2020 03:54:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 8 Oct 2020 03:54:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 8 Oct 2020 03:54:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DE7X/iT6GoH6cvbS0OXWo/6pz0RUpCI8q+I7sI7bAXCCYVS+D0y3tCWFuQfSCnzvqZ1DTi8e/S8ZNpF7UZJJTKFEqgG23wlSdG1n56pY6a58rLZbm1ezMNs8AJEMAc5AHMjUJxH9Y3ZZZclXX4fseosxD+KZctNS/fDpGVd9UcYIuDFAHIqy9mrVHDeSwvx3hCw4+x5JjuNvr5bkljVSmUMpem5DPKRHGbMPpNwMCIXje0g2QXuoSvbs8tHmkgWmlPnuaFHd8E5omMM9EZjii8y434KGFj3qdzqivZxCWzBOI2q3vOGSoPJ00ND6uTfy9Dd5f6UYBHnJ0tXMkglRUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xv3l+rnoGQBgOxEOuo9zuh6RqX/t61RgAsow2PPWeR0=;
 b=bIQHoorrnJ0LyGM9jJMOME8OIsyzuHPv8xpP+Zx9TDl4xWZsUzwVgdCfhQ6N4MWfKOQ0DzFhwpFZ4+1VTH7Dd2CIeE4ThYp2DKNF5QkAW/qpOJd18Ley9MYDb8pmfps5J9Ff+aVThzRVt5jx2XBXrDy2Fqaif4mhbQg4OxjDQwpfQghWHz7DsVH63rffYfIC88toDAihLn2PQMU7k4z1hjuFECmt5m4Fy3cl5Vyw75EgCLHypL7pyrOSfKr17rsqrvB80bYRZIwmw308L5pRmEbi1DR+HvUiuCLMfyOKNtRMC+zEqkO+dGF879dxwXA8r0FF/t7PpCCF7d/Yfq+k7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xv3l+rnoGQBgOxEOuo9zuh6RqX/t61RgAsow2PPWeR0=;
 b=pPeTA9w8Haho6EAqvo/jVpJaKqMTnNkPm5Ijj/9T4eFfGUKHuiqWfzR74FP+qgywnG7olS9nv6hvEaF6CnDToJHU3zr1nO+RhGEqgO09kzfC5jn1xP60qJ+fT7vgYv3FqLEEK4T2MTQe170DYHhEpAmxEWB70CX/nyH4RetgOFU=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM6PR11MB3452.namprd11.prod.outlook.com (2603:10b6:5:9::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.42; Thu, 8 Oct 2020 10:54:51 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c%5]) with mapi id 15.20.3433.045; Thu, 8 Oct 2020
 10:54:51 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v4 4/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
Thread-Topic: [PATCH v4 4/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
Thread-Index: AQHWnRiQsJ+XebQSo0uGE+XglmG5+KmNcEsAgAAYHQA=
Date:   Thu, 8 Oct 2020 10:54:51 +0000
Message-ID: <DM6PR11MB28764EC5E1F89D417D700F29B80B0@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com>
 <20201008020936.19894-5-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFpUv8yeVrWVLRKvz4eKsSDdk0y4dKY2mYs07zpA2UqNdw@mail.gmail.com>
In-Reply-To: <CAPDyKFpUv8yeVrWVLRKvz4eKsSDdk0y4dKY2mYs07zpA2UqNdw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.177.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa4a24c8-b692-4944-2537-08d86b78954c
x-ms-traffictypediagnostic: DM6PR11MB3452:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3452E09ECBB389847E008BB9B80B0@DM6PR11MB3452.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M5/A/VBEkOSz8aoqegSXjEcS1IY2BXyC3hdq1viEY1rc9yGm0DNclGZOOhUxWcxvMJYsAJdqf3WnL8siIVsFwxaNXii6ecGhaHIvpSAAQL5yG0EfSm35r8pQGVXV35W9BhQ10kOKZoHd+g77zXJlfD8UdvPkl3UMU3oGcmZZjf+l7DvE4Qtn3ks9S5y4wdQHYcsp5+34f2ZeO6GN8GelMiICG/xxpMHQ3hpjggXlYwLS1NGMCxYZ+k4fKOzedYyhk4uEub1+AVSkTgRWPsrAavj05ATXlM+amnupzhfWhmQTl9MAWfC2yu4e7xsUVsIRpUdowzaTICrq41fl3pSCtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(2906002)(33656002)(55016002)(52536014)(26005)(5660300002)(4326008)(186003)(66476007)(54906003)(316002)(8936002)(86362001)(64756008)(478600001)(83380400001)(6916009)(71200400001)(7696005)(9686003)(66946007)(8676002)(66556008)(6506007)(66446008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: D1VLGm6D/0yzr6PtzN8awuH+ucOW21ofZtLiWoiMJ5hnSjgHSUZrAG7i6jj4zGDjlIA5COynJrOwP9jn3cvbxFtAi/5pVIOWEUW7iw//81snb6VjiKYocD7SirUNbN01ar3A/GRZNM9iAwvdLc2L5LLbkxWIAsBdJrP2CLn0BYjQQ3ab0Vlx4jJYqwBWdi9PQu5BF1LP49T7W4Ey4JRZIis8zey23EPTaClhGvhLPGT+jDRBJkkacblHWM16AVj2eNisMTfiHf9I4/L71t/uxXRXvO/8Jd+1+7LF1j4A+eK1CGmJ9tA5J1EvJ4HGQZ8OD/uY5Z1HGRbzfjKiTancuIho9XxHfwgSZTac96cnVwoGYGqlz7l4TeDOxg6tduUQZDpWlbpASXJ6KqtLOkbGwWQanB9CyDZonBx9573euji4OpJ/TAF/YBjC1vtbt2l6BpBluNOq5bxANWK7QdSTx9jvDrdaaUanryT1xSObbjCXptr2i/YK7MKG26uCzGeDXjKmxluJfmpEljjdkUudFyl1VP/9/T/tWpOsUjuYokIndNCGOfCTiTojh+Wd+N198ZFuJSOmivr9SjnpAZeuUHCTwoMzzg6DhrahLrVpiFzIr9VsZ9eBaYiax7D07pLvfY+vDhDZEirwqOFX+7CQAQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4a24c8-b692-4944-2537-08d86b78954c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2020 10:54:51.6299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8bAMv2SC9yXLN8kPCsb3NUklsZgSWUU6vjwFFXWhfhOgSopqbFLcebtTxQs6+HB+danmUYsfQgZXB/dYP+wjeubormSqDlXwe8FrhG5rM8ZJX0cHUJq/FSn87wNjf+Fh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3452
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGksDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFVsZiBIYW5zc29uIDx1
bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPlNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDgsIDIwMjAg
NToyOCBQTQ0KPlRvOiBadWxraWZsaSwgTXVoYW1tYWQgSHVzYWluaSA8bXVoYW1tYWQuaHVzYWlu
aS56dWxraWZsaUBpbnRlbC5jb20+DQo+Q2M6IEh1bnRlciwgQWRyaWFuIDxhZHJpYW4uaHVudGVy
QGludGVsLmNvbT47IE1pY2hhbCBTaW1law0KPjxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT47IFNo
ZXZjaGVua28sIEFuZHJpeQ0KPjxhbmRyaXkuc2hldmNoZW5rb0BpbnRlbC5jb20+OyBsaW51eC1t
bWNAdmdlci5rZXJuZWwub3JnOyBMaW51eCBBUk0NCj48bGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgtDQo+a2VybmVs
QHZnZXIua2VybmVsLm9yZz47IFJhamEgU3VicmFtYW5pYW4sIExha3NobWkgQmFpDQo+PGxha3No
bWkuYmFpLnJhamEuc3VicmFtYW5pYW5AaW50ZWwuY29tPjsgV2FuIE1vaGFtYWQsIFdhbiBBaG1h
ZA0KPlphaW5pZSA8d2FuLmFobWFkLnphaW5pZS53YW4ubW9oYW1hZEBpbnRlbC5jb20+OyBBcm5k
IEJlcmdtYW5uDQo+PGFybmRAYXJuZGIuZGU+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NCA0LzRd
IG1tYzogc2RoY2ktb2YtYXJhc2FuOiBFbmFibGUgVUhTLTEgc3VwcG9ydCBmb3INCj5LZWVtIEJh
eSBTT0MNCj4NCj5PbiBUaHUsIDggT2N0IDIwMjAgYXQgMDQ6MTIsIDxtdWhhbW1hZC5odXNhaW5p
Lnp1bGtpZmxpQGludGVsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gRnJvbTogTXVoYW1tYWQgSHVzYWlu
aSBadWxraWZsaSA8bXVoYW1tYWQuaHVzYWluaS56dWxraWZsaUBpbnRlbC5jb20+DQo+Pg0KPj4g
Vm9sdGFnZSBzd2l0Y2hpbmcgc2VxdWVuY2UgaXMgbmVlZGVkIHRvIHN1cHBvcnQgVUhTLTEgaW50
ZXJmYWNlLg0KPj4gVGhlcmUgYXJlIDIgcGxhY2VzIHRvIGNvbnRyb2wgdGhlIHZvbHRhZ2UuDQo+
PiAxKSBCeSBzZXR0aW5nIHRoZSBBT04gcmVnaXN0ZXIgdXNpbmcgZmlybXdhcmUgZHJpdmVyIGNh
bGxpbmcNCj4+IHN5c3RlbS1sZXZlbCBwbGF0Zm9ybSBtYW5hZ2VtZW50IGxheWVyIChTTUMpIHRv
IHNldCB0aGUgcmVnaXN0ZXIuDQo+PiAyKSBCeSBjb250cm9sbGluZyB0aGUgR1BJTyBleHBhbmRl
ciB2YWx1ZSB0byBkcml2ZSBlaXRoZXIgMS44ViBvciAzLjNWDQo+PiBmb3IgcG93ZXIgbXV4IGlu
cHV0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IE11aGFtbWFkIEh1c2FpbmkgWnVsa2lmbGkNCj4+
IDxtdWhhbW1hZC5odXNhaW5pLnp1bGtpZmxpQGludGVsLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBB
bmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNvbT4NCj4+IFJldmlld2Vk
LWJ5OiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4g
IGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMgfCAxMjYNCj4+ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEyNiBpbnNlcnRpb25zKCsp
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMN
Cj4+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4uYw0KPj4gaW5kZXggNDZhZWE2
NTE2MTMzLi5lYTI0NjdiMDA3M2QgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLW9mLWFyYXNhbi5jDQo+PiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWFyYXNh
bi5jDQo+PiBAQCAtMTYsNiArMTYsNyBAQA0KPj4gICAqLw0KPj4NCj4+ICAjaW5jbHVkZSA8bGlu
dXgvY2xrLXByb3ZpZGVyLmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L2dwaW8vY29uc3VtZXIuaD4N
Cj4+ICAjaW5jbHVkZSA8bGludXgvbWZkL3N5c2Nvbi5oPg0KPj4gICNpbmNsdWRlIDxsaW51eC9t
b2R1bGUuaD4NCj4+ICAjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQo+PiBAQCAtMjMsNiAr
MjQsNyBAQA0KPj4gICNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCj4+ICAjaW5jbHVkZSA8bGlu
dXgvb2YuaD4NCj4+ICAjaW5jbHVkZSA8bGludXgvZmlybXdhcmUveGxueC16eW5xbXAuaD4NCj4+
ICsjaW5jbHVkZSA8bGludXgvZmlybXdhcmUvaW50ZWwva2VlbWJheV9maXJtd2FyZS5oPg0KPj4N
Cj4+ICAjaW5jbHVkZSAiY3FoY2kuaCINCj4+ICAjaW5jbHVkZSAic2RoY2ktcGx0Zm0uaCINCj4+
IEBAIC0xMzYsNiArMTM4LDcgQEAgc3RydWN0IHNkaGNpX2FyYXNhbl9jbGtfZGF0YSB7DQo+PiAg
ICogQHNvY19jdGxfYmFzZTogICAgICBQb2ludGVyIHRvIHJlZ21hcCBmb3Igc3lzY29uIGZvciBz
b2NfY3RsIHJlZ2lzdGVycy4NCj4+ICAgKiBAc29jX2N0bF9tYXA6ICAgICAgIE1hcCB0byBnZXQg
b2Zmc2V0cyBpbnRvIHNvY19jdGwgcmVnaXN0ZXJzLg0KPj4gICAqIEBxdWlya3M6ICAgICAgICAg
ICAgQXJhc2FuIGRldmlhdGlvbnMgZnJvbSBzcGVjLg0KPj4gKyAqIEB1aHNfZ3BpbzogICAgICAg
ICAgUG9pbnRlciB0byB0aGUgdWhzIGdwaW8uDQo+PiAgICovDQo+PiAgc3RydWN0IHNkaGNpX2Fy
YXNhbl9kYXRhIHsNCj4+ICAgICAgICAgc3RydWN0IHNkaGNpX2hvc3QgKmhvc3Q7DQo+PiBAQCAt
MTUwLDYgKzE1Myw3IEBAIHN0cnVjdCBzZGhjaV9hcmFzYW5fZGF0YSB7DQo+PiAgICAgICAgIHN0
cnVjdCByZWdtYXAgICAqc29jX2N0bF9iYXNlOw0KPj4gICAgICAgICBjb25zdCBzdHJ1Y3Qgc2Ro
Y2lfYXJhc2FuX3NvY19jdGxfbWFwICpzb2NfY3RsX21hcDsNCj4+ICAgICAgICAgdW5zaWduZWQg
aW50ICAgIHF1aXJrczsNCj4+ICsgICAgICAgc3RydWN0IGdwaW9fZGVzYyAqdWhzX2dwaW87DQo+
Pg0KPj4gIC8qIENvbnRyb2xsZXIgZG9lcyBub3QgaGF2ZSBDRCB3aXJlZCBhbmQgd2lsbCBub3Qg
ZnVuY3Rpb24gbm9ybWFsbHkgd2l0aG91dA0KPiovDQo+PiAgI2RlZmluZSBTREhDSV9BUkFTQU5f
UVVJUktfRk9SQ0VfQ0RURVNUICAgICAgICBCSVQoMCkNCj4+IEBAIC0zNjEsNiArMzY1LDExMiBA
QCBzdGF0aWMgaW50IHNkaGNpX2FyYXNhbl92b2x0YWdlX3N3aXRjaChzdHJ1Y3QNCj5tbWNfaG9z
dCAqbW1jLA0KPj4gICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+ICB9DQo+Pg0KPj4gK3N0YXRp
YyBpbnQgc2RoY2lfYXJhc2FuX2tlZW1iYXlfdm9sdGFnZV9zd2l0Y2goc3RydWN0IG1tY19ob3N0
ICptbWMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
bW1jX2lvcyAqaW9zKSB7DQo+PiArICAgICAgIHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0ID0gbW1j
X3ByaXYobW1jKTsNCj4+ICsgICAgICAgc3RydWN0IHNkaGNpX3BsdGZtX2hvc3QgKnBsdGZtX2hv
c3QgPSBzZGhjaV9wcml2KGhvc3QpOw0KPj4gKyAgICAgICBzdHJ1Y3Qgc2RoY2lfYXJhc2FuX2Rh
dGEgKnNkaGNpX2FyYXNhbiA9IHNkaGNpX3BsdGZtX3ByaXYocGx0Zm1faG9zdCk7DQo+PiArICAg
ICAgIHUxNiBjdHJsXzIsIGNsazsNCj4+ICsgICAgICAgaW50IHJldDsNCj4+ICsNCj4+ICsgICAg
ICAgc3dpdGNoIChpb3MtPnNpZ25hbF92b2x0YWdlKSB7DQo+PiArICAgICAgIGNhc2UgTU1DX1NJ
R05BTF9WT0xUQUdFXzE4MDoNCj4+ICsgICAgICAgICAgICAgICBjbGsgPSBzZGhjaV9yZWFkdyho
b3N0LCBTREhDSV9DTE9DS19DT05UUk9MKTsNCj4+ICsgICAgICAgICAgICAgICBjbGsgJj0gflNE
SENJX0NMT0NLX0NBUkRfRU47DQo+PiArICAgICAgICAgICAgICAgc2RoY2lfd3JpdGV3KGhvc3Qs
IGNsaywgU0RIQ0lfQ0xPQ0tfQ09OVFJPTCk7DQo+PiArDQo+PiArICAgICAgICAgICAgICAgY2xr
ID0gc2RoY2lfcmVhZHcoaG9zdCwgU0RIQ0lfQ0xPQ0tfQ09OVFJPTCk7DQo+PiArICAgICAgICAg
ICAgICAgaWYgKGNsayAmIFNESENJX0NMT0NLX0NBUkRfRU4pDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gLUVBR0FJTjsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgICBzZGhjaV93
cml0ZWIoaG9zdCwgU0RIQ0lfUE9XRVJfT04gfCBTREhDSV9QT1dFUl8xODAsDQo+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNESENJX1BPV0VSX0NPTlRST0wpOw0KPj4gKw0K
Pj4gKyAgICAgICAgICAgICAgIC8qDQo+PiArICAgICAgICAgICAgICAgICogU2V0IFZERElPX0Ig
dm9sdGFnZSB0byBMb3cgZm9yIDEuOFYNCj4+ICsgICAgICAgICAgICAgICAgKiB3aGljaCBpcyBj
b250cm9sbGluZyBieSBHUElPIEV4cGFuZGVyLg0KPj4gKyAgICAgICAgICAgICAgICAqLw0KPj4g
KyAgICAgICAgICAgICAgIGdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChzZGhjaV9hcmFzYW4tPnVo
c19ncGlvLCAwKTsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgICAvKg0KPj4gKyAgICAgICAgICAg
ICAgICAqIFRoaXMgaXMgbGlrZSBhIGZpbmFsIGdhdGVrZWVwZXIuIE5lZWQgdG8gZW5zdXJlIGNo
YW5nZWQgdm9sdGFnZQ0KPj4gKyAgICAgICAgICAgICAgICAqIGlzIHNldHRsZWQgYmVmb3JlIGFu
ZCBhZnRlciB0dXJuIG9uIHRoaXMgYml0Lg0KPj4gKyAgICAgICAgICAgICAgICAqLw0KPj4gKyAg
ICAgICAgICAgICAgIHVzbGVlcF9yYW5nZSgxMDAwLCAxMTAwKTsNCj4+ICsNCj4+ICsgICAgICAg
ICAgICAgICByZXQgPSBrZWVtYmF5X3NkX3ZvbHRhZ2Vfc2VsZWN0aW9uKEtFRU1CQVlfU0VUXzFW
OF9WT0xUKTsNCj4+ICsgICAgICAgICAgICAgICBpZiAocmV0KQ0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIHJldDsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgICB1c2xlZXBfcmFu
Z2UoMTAwMCwgMTEwMCk7DQo+DQo+Tm8sIHNvcnJ5LCBidXQgSSBkb24ndCBsaWtlIHRoaXMuDQo+
DQo+VGhpcyBsb29rcyBsaWtlIGEgR1BJTyByZWd1bGF0b3Igd2l0aCBhbiBleHRlbnNpb24gb2Yg
dXNpbmcgdGhlDQo+a2VlbWJheV9zZF92b2x0YWdlX3NlbGVjdGlvbigpIHRoaW5neS4gSSB0aGlu
ayB5b3UgY2FuIG1vZGVsIHRoZXNlIHRoaW5ncw0KPmJlaGluZCBhIHJlZ3VsYXRvciBhbmQgaG9v
ayBpdCB1cCBhcyBhIHZxbW1jIHN1cHBseSBpbiBEVCBpbnN0ZWFkLiBCVFcsIHRoaXMgaXMNCj50
aGUgY29tbW9uIHdheSB3ZSBkZWFsIHdpdGggdGhlc2UgdGhpbmdzIGZvciBtbWMgaG9zdCBkcml2
ZXJzLg0KDQpUaGUgU0RjYXJkIGZvciBLZWVtIEJheSBTT0MgZG9lcyBub3QgaGF2ZSBpdHMgb3du
IHZvbHRhZ2UgcmVndWxhdG9yLiANClRoZXJlIGFyZSAyIHBsYWNlcyB0byBjb250cm9sIHRoZSB2
b2x0YWdlLg0KMSkgQnkgc2V0dGluZyB0aGUgQU9OIHJlZ2lzdGVyIGNhbGxpbmcgc3lzdGVtLWxl
dmVsIHBsYXRmb3JtIG1hbmFnZW1lbnQgbGF5ZXIgKFNNQykNCiAgIHRvIHNldCB0aGUgSS9PIHBh
ZHMgdm9sdGFnZSBmb3IgcGFydGljdWxhciBHUElPcyBsaW5lIGZvciBjbGssZGF0YSBhbmQgY21k
Lg0KICAgVGhlIHJlYXNvbiB3aHkgSSB1c2UgdGhpcyBrZWVtYmF5X3NkX3ZvbHRhZ2Vfc2VsZWN0
aW9uKCkgdmlhIHNtY2NjIGludGVyZmFjZSBpdCBiZWNhdXNlIGR1cmluZyB2b2x0YWdlIHN3aXRj
aGluZyANCiAgIEkgbmVlZCB0byBhY2Nlc3MgdG8gQU9OIHJlZ2lzdGVyLiBPbiBhIHNlY3VyZSBz
eXN0ZW0sIHdlIGNvdWxkIG5vdCBkaXJlY3RseSBhY2Nlc3MgdG8gQU9OIHJlZ2lzdGVyIGR1ZSB0
byBzb21lIHNlY3VyaXR5IGNvbmNlcm4gZnJvbSBkcml2ZXIgc2lkZSwgdGh1cw0KICAgY2Fubm90
IGV4cG9zZWQgYW55IHJlZ2lzdGVyIG9yIGFkZHJlc3MuDQoyKSBCeSBjb250cm9sbGluZyB0aGUg
R1BJTyBleHBhbmRlciB2YWx1ZSB0byBkcml2ZSBlaXRoZXIgMS44ViBvciAzLjNWIGZvciBwb3dl
ciBtdXggaW5wdXQuDQoNClRoYW5rcw0KPg0KPj4gKw0KPj4gKyAgICAgICAgICAgICAgIGN0cmxf
MiA9IHNkaGNpX3JlYWR3KGhvc3QsIFNESENJX0hPU1RfQ09OVFJPTDIpOw0KPj4gKyAgICAgICAg
ICAgICAgIGN0cmxfMiB8PSBTREhDSV9DVFJMX1ZERF8xODA7DQo+PiArICAgICAgICAgICAgICAg
c2RoY2lfd3JpdGV3KGhvc3QsIGN0cmxfMiwgU0RIQ0lfSE9TVF9DT05UUk9MMik7DQo+PiArDQo+
PiArICAgICAgICAgICAgICAgLyogU2xlZXAgZm9yIDVtcyB0byBzdGFiaWxpemUgMS44ViByZWd1
bGF0b3IgKi8NCj4+ICsgICAgICAgICAgICAgICB1c2xlZXBfcmFuZ2UoNTAwMCwgNTUwMCk7DQo+
PiArDQo+PiArICAgICAgICAgICAgICAgLyogMS44ViByZWd1bGF0b3Igb3V0cHV0IHNob3VsZCBi
ZSBzdGFibGUgd2l0aGluIDUgbXMgKi8NCj4+ICsgICAgICAgICAgICAgICBjdHJsXzIgPSBzZGhj
aV9yZWFkdyhob3N0LCBTREhDSV9IT1NUX0NPTlRST0wyKTsNCj4+ICsgICAgICAgICAgICAgICBp
ZiAoIShjdHJsXzIgJiBTREhDSV9DVFJMX1ZERF8xODApKQ0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIC1FQUdBSU47DQo+PiArDQo+PiArICAgICAgICAgICAgICAgY2xrICA9IHNk
aGNpX3JlYWR3KGhvc3QsIFNESENJX0NMT0NLX0NPTlRST0wpOw0KPj4gKyAgICAgICAgICAgICAg
IGNsayB8PSBTREhDSV9DTE9DS19DQVJEX0VOOw0KPj4gKyAgICAgICAgICAgICAgIHNkaGNpX3dy
aXRldyhob3N0LCBjbGssIFNESENJX0NMT0NLX0NPTlRST0wpOw0KPj4gKyAgICAgICAgICAgICAg
IGJyZWFrOw0KPj4gKyAgICAgICBjYXNlIE1NQ19TSUdOQUxfVk9MVEFHRV8zMzA6DQo+PiArICAg
ICAgICAgICAgICAgLyoNCj4+ICsgICAgICAgICAgICAgICAgKiBTZXQgVkRESU9fQiB2b2x0YWdl
IHRvIEhpZ2ggZm9yIDMuM1YNCj4+ICsgICAgICAgICAgICAgICAgKiB3aGljaCBpcyBjb250cm9s
bGluZyBieSBHUElPIEV4cGFuZGVyLg0KPj4gKyAgICAgICAgICAgICAgICAqLw0KPj4gKyAgICAg
ICAgICAgICAgIGdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChzZGhjaV9hcmFzYW4tPnVoc19ncGlv
LCAxKTsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgICAvKg0KPj4gKyAgICAgICAgICAgICAgICAq
IFRoaXMgaXMgbGlrZSBhIGZpbmFsIGdhdGVrZWVwZXIuIE5lZWQgdG8gZW5zdXJlIGNoYW5nZWQg
dm9sdGFnZQ0KPj4gKyAgICAgICAgICAgICAgICAqIGlzIHNldHRsZWQgYmVmb3JlIGFuZCBhZnRl
ciB0dXJuIG9uIHRoaXMgYml0Lg0KPj4gKyAgICAgICAgICAgICAgICAqLw0KPj4gKyAgICAgICAg
ICAgICAgIHVzbGVlcF9yYW5nZSgxMDAwLCAxMTAwKTsNCj4+ICsNCj4+ICsgICAgICAgICAgICAg
ICByZXQgPSBrZWVtYmF5X3NkX3ZvbHRhZ2Vfc2VsZWN0aW9uKEtFRU1CQVlfU0VUXzNWM19WT0xU
KTsNCj4+ICsgICAgICAgICAgICAgICBpZiAocmV0KQ0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIHJldDsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgICB1c2xlZXBfcmFuZ2UoMTAw
MCwgMTEwMCk7DQo+PiArDQo+PiArICAgICAgICAgICAgICAgLyogU2V0IDEuOFYgU2lnbmFsIEVu
YWJsZSBpbiB0aGUgSG9zdCBDb250cm9sMiByZWdpc3RlciB0byAwICovDQo+PiArICAgICAgICAg
ICAgICAgY3RybF8yID0gc2RoY2lfcmVhZHcoaG9zdCwgU0RIQ0lfSE9TVF9DT05UUk9MMik7DQo+
PiArICAgICAgICAgICAgICAgY3RybF8yICY9IH5TREhDSV9DVFJMX1ZERF8xODA7DQo+PiArICAg
ICAgICAgICAgICAgc2RoY2lfd3JpdGV3KGhvc3QsIGN0cmxfMiwgU0RIQ0lfSE9TVF9DT05UUk9M
Mik7DQo+PiArDQo+PiArICAgICAgICAgICAgICAgLyogU2xlZXAgZm9yIDVtcyB0byBzdGFiaWxp
emUgMy4zViByZWd1bGF0b3IgKi8NCj4+ICsgICAgICAgICAgICAgICB1c2xlZXBfcmFuZ2UoNTAw
MCwgNTUwMCk7DQo+PiArDQo+PiArICAgICAgICAgICAgICAgLyogMy4zViByZWd1bGF0b3Igb3V0
cHV0IHNob3VsZCBiZSBzdGFibGUgd2l0aGluIDUgbXMgKi8NCj4+ICsgICAgICAgICAgICAgICBj
dHJsXzIgPSBzZGhjaV9yZWFkdyhob3N0LCBTREhDSV9IT1NUX0NPTlRST0wyKTsNCj4+ICsgICAg
ICAgICAgICAgICBpZiAoY3RybF8yICYgU0RIQ0lfQ1RSTF9WRERfMTgwKQ0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIC1FQUdBSU47DQo+PiArDQo+PiArICAgICAgICAgICAgICAg
YnJlYWs7DQo+PiArICAgICAgIGRlZmF1bHQ6DQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIC1F
SU5WQUw7DQo+PiArICAgICAgIH0NCj4+ICsNCj4+ICsgICAgICAgcmV0dXJuIDA7DQo+PiArfQ0K
Pj4gKw0KPj4gK3N0YXRpYyBpbnQgc2RoY2lfYXJhc2FuX2tlZW1iYXlfc2VsZWN0X2RyaXZlX3N0
cmVuZ3RoKHN0cnVjdCBtbWNfY2FyZA0KPipjYXJkLA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBtYXhfZHRyLCBpbnQgaG9zdF9kcnYsDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGNhcmRfZHJ2LCBp
bnQgKmRydl90eXBlKSB7DQo+PiArICAgICAgIGlmIChjYXJkLT5ob3N0LT5pb3Muc2lnbmFsX3Zv
bHRhZ2UgPT0gTU1DX1NJR05BTF9WT0xUQUdFXzE4MCkNCj4+ICsgICAgICAgICAgICAgICAqZHJ2
X3R5cGUgPSBNTUNfU0VUX0RSSVZFUl9UWVBFX0M7DQo+PiArDQo+PiArICAgICAgIHJldHVybiAw
Ow0KPj4gK30NCj4+ICsNCj4+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHNkaGNpX29wcyBzZGhjaV9h
cmFzYW5fb3BzID0gew0KPj4gICAgICAgICAuc2V0X2Nsb2NrID0gc2RoY2lfYXJhc2FuX3NldF9j
bG9jaywNCj4+ICAgICAgICAgLmdldF9tYXhfY2xvY2sgPSBzZGhjaV9wbHRmbV9jbGtfZ2V0X21h
eF9jbG9jaywgQEAgLTE2MDEsNg0KPj4gKzE3MTEsMjIgQEAgc3RhdGljIGludCBzZGhjaV9hcmFz
YW5fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+ICAgICAgICAgICAgICAg
ICBob3N0LT5tbWMtPmNhcHMgfD0gTU1DX0NBUF9XQUlUX1dISUxFX0JVU1k7DQo+PiAgICAgICAg
IH0NCj4+DQo+PiArICAgICAgIGlmIChvZl9kZXZpY2VfaXNfY29tcGF0aWJsZShucCwgImludGVs
LGtlZW1iYXktc2RoY2ktNS4xLXNkIikpIHsNCj4+ICsgICAgICAgICAgICAgICBzdHJ1Y3QgZ3Bp
b19kZXNjICp1aHM7DQo+PiArDQo+PiArICAgICAgICAgICAgICAgdWhzID0gZGV2bV9ncGlvZF9n
ZXRfb3B0aW9uYWwoZGV2LCAidWhzIiwgR1BJT0RfT1VUX0hJR0gpOw0KPj4gKyAgICAgICAgICAg
ICAgIGlmIChJU19FUlIodWhzKSkNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBk
ZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUih1aHMpLCAiY2FuJ3QNCj4+ICsgZ2V0IHVocyBncGlv
XG4iKTsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgICBzZGhjaV9hcmFzYW4tPnVoc19ncGlvID0g
dWhzOw0KPj4gKw0KPj4gKyAgICAgICAgICAgICAgIGhvc3QtPm1tY19ob3N0X29wcy5zdGFydF9z
aWduYWxfdm9sdGFnZV9zd2l0Y2ggPQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgc2RoY2lf
YXJhc2FuX2tlZW1iYXlfdm9sdGFnZV9zd2l0Y2g7DQo+PiArDQo+PiArICAgICAgICAgICAgICAg
aG9zdC0+bW1jX2hvc3Rfb3BzLnNlbGVjdF9kcml2ZV9zdHJlbmd0aCA9DQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICBzZGhjaV9hcmFzYW5fa2VlbWJheV9zZWxlY3RfZHJpdmVfc3RyZW5ndGg7
DQo+PiArICAgICAgIH0NCj4+ICsNCj4+ICAgICAgICAgc2RoY2lfYXJhc2FuX3VwZGF0ZV9iYXNl
Y2xrZnJlcShob3N0KTsNCj4+DQo+PiAgICAgICAgIHJldCA9IHNkaGNpX2FyYXNhbl9yZWdpc3Rl
cl9zZGNsayhzZGhjaV9hcmFzYW4sIGNsa194aW4sDQo+PiAmcGRldi0+ZGV2KTsNCj4+IC0tDQo+
PiAyLjE3LjENCj4+DQo+DQo+S2luZCByZWdhcmRzDQo+VWZmZQ0K
