Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03CCEB7BA6
	for <lists+linux-mmc@lfdr.de>; Thu, 19 Sep 2019 16:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389781AbfISOGx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 19 Sep 2019 10:06:53 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:14284 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389045AbfISOGx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Sep 2019 10:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568902012; x=1600438012;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WAg+AdM9zX+aobjuEt0wRkwb3EMVAvCa0EzheETqppc=;
  b=Ov6YbuZKng9woR+pdgPMgMukIkgG3gG2m4mF8xhlAxMEokoyidmHXWSv
   oZFe3TzfoTqotjYwzjrPzKKA6i861k8t0H8H6SShYII3sraMtM9rm4pdW
   GjJvH50rDrkAdBFo0ykyYE1AxMV/RoRgXxOKTDJ60ZbxPS4ajqR07Y9HF
   ZYUXcvq5xALwbNBIJKGoTLyLfohFlpqlQ4cMYJtMqznma5ZLGWRgw6cjM
   mTB1fjZ0UghUiFBA07gB9TazCJsbxPAvhz1K5KcxtzkeIMGptqOpf84na
   DzfDI92qZEHnYN9wpx6SIOM6AZqFIAdnpvgF/VrZtHwQBUrRh2+7lxWr0
   A==;
IronPort-SDR: I7TjQEwRD4UpZBd0zuGHsn5lTz4PBsCSpD3EEO1q6R9IFv82XXAtCf8RcwB5DFfMxt2yNlKnpN
 D9j67awn5stUf6kFzI1ZanD86J1e9Qg+YTeXPiMGd0tWfq7CKcE5jDlVUFwSuynbCH6W1sbg7a
 x3qZGZU++T/97PfHZEOOrtPuVf+faTgSxi39IGr6POFl6NBfgFjKUXPWOI4I8nohinjjOzEzaO
 NQuMsSaRpyPsqhQT9FIjPXtgASe5Cm7B+7Xzn5zNPTQCCm2aOQq3bm5X7nKvfQZHnjjYYTdT1n
 Snk=
X-IronPort-AV: E=Sophos;i="5.64,523,1559491200"; 
   d="scan'208";a="225460458"
Received: from mail-by2nam01lp2058.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.58])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2019 22:06:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D45h3/FqEUqfmWYaUY13LwiqAULIimszTP65CSPuTABh8kA3TsnUDGb0LIJK7ngNom84sykQoswCZS3UWOQZ5KB8MVWFNtQKGzKuS33vFa6TN+Dpxqk0tYZLcbutMi2QGdc9CIidpBKiYMPAeEMFcfE9xnrBBGJHNwIBgrazmfQ8neYVIIcUybUpiYR3+zG0DCs5ne8xvhV3zKU9ft2DCQ4sca/mdUs7a2nHNMAUIPi1x6AQ5+8nyJhjktPsm+xE8VTor7LuYarS/ahdce4zyH8OXA1ShWipsuS28zJ1HOX5gdeGpiEeIU+YDli/LwpVaQ/Nqaw+VdhK0MmbmKaxUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAg+AdM9zX+aobjuEt0wRkwb3EMVAvCa0EzheETqppc=;
 b=HbrFUBby2iXs0TDcGd2MkWqvz8HgIfqzeEEUp9p/A5iVUakRmwfwLtbf4CGP694FyyG8bVMxn7T7lLGk1on37FDPdVQG2t5eC6rN6zBF9OkWoVYNgrhQBMsZMyN2IL7KzLIni7y0Yv7QaFdSjukEiaJIXk0G+6vvi3xxqY5UDrZQWbJqTFR0Y8g5BdXlaLfmhDH7NjxdSOYUfGCJUPED1YVWXTqpCFMXJ1X+2bILUysOLBISBTM4RXVRDyOZDHt970idEwfMYvmLc4E8soQXcWEq8niiLm/5PIS8kp2Ad5vJBzWQ4rrvvQ9AgI8W1b5hJ+4xUIbvp+MpxlbVbmWeog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAg+AdM9zX+aobjuEt0wRkwb3EMVAvCa0EzheETqppc=;
 b=ThqHB5T46xV6leuXZUra3elul78DYNu0A8uFf0UAIojRIYFJhEPEBdQNoX+ojcv4hZw4DMt2SwRa/diRUcQJrAR2DJLynOSRa7HkIduAHdHxWnElEmYvtj9ExFG3bP9A6HlSDExLcIoM4b1dF/cbCnQT16f0Vu8Yq2jt2+DQNRs=
Received: from MN2PR04MB6991.namprd04.prod.outlook.com (10.186.144.209) by
 MN2PR04MB5981.namprd04.prod.outlook.com (20.178.246.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.22; Thu, 19 Sep 2019 14:06:50 +0000
Received: from MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::9c2b:ac1b:67b8:f371]) by MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::9c2b:ac1b:67b8:f371%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 14:06:50 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Michael Heimpold <mhei@heimpold.de>,
        "chris@printf.net" <chris@printf.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH mmc-utils v2 0/5] Various fixes for mmc-utils
Thread-Topic: [PATCH mmc-utils v2 0/5] Various fixes for mmc-utils
Thread-Index: AQHVaa67ZkDrfKUAHUuBW2wff6DItKcyx9owgABG3QCAAAPxgA==
Date:   Thu, 19 Sep 2019 14:06:49 +0000
Message-ID: <MN2PR04MB69915A035B856C0038633F7AFC890@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <20190912210509.19816-1-mhei@heimpold.de>
 <MN2PR04MB6991CE61681D33F1F7E76ADAFC890@MN2PR04MB6991.namprd04.prod.outlook.com>
 <CAPDyKFrae36rymcD-o9RELiWVTzMd-ccM2q1q-dO7GiWYaqw+w@mail.gmail.com>
In-Reply-To: <CAPDyKFrae36rymcD-o9RELiWVTzMd-ccM2q1q-dO7GiWYaqw+w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 197f06eb-bd9e-4bd5-1058-08d73d0a9dae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR04MB5981;
x-ms-traffictypediagnostic: MN2PR04MB5981:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR04MB59815C9EC529D65CA2F032FCFC890@MN2PR04MB5981.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(199004)(189003)(6306002)(55016002)(9686003)(4326008)(229853002)(6246003)(6116002)(86362001)(3846002)(71190400001)(25786009)(71200400001)(256004)(14444005)(305945005)(74316002)(2906002)(966005)(6436002)(66066001)(478600001)(7736002)(52536014)(81166006)(81156014)(6916009)(8936002)(316002)(99286004)(14454004)(5660300002)(7696005)(76176011)(6506007)(186003)(26005)(102836004)(486006)(66946007)(476003)(446003)(11346002)(8676002)(66476007)(66446008)(64756008)(66556008)(33656002)(54906003)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5981;H:MN2PR04MB6991.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jfT5tgWEuiZRSZU627OsR7vKPtnORhW/AjDm7U7GeSdmon6X/EvK/OpD+M+D1eGzVZKcyVZaASR5fVC6frsQ90Qe0o1jTDOBSAXK4gfMZJqDcfE61e+b2DkS2HUWBOCrhrgEOixQTeo1iWf9CULg4C1afaNDZy7hIa8Ldo4JKV6YphYsPS/tt30SH32hFbieSCryduJsym2xTSrl0Aob5hT1Bo/jAxm7dZn+uDuIIFoSqZlXPLDJY73ximB1QN/5hiF3Bh1yUu7J6Mk+wMwAkFDZ6gohs1OEmIO8WVoIUpiVN/yUx9+T+ft7YSfctky+OoypXs6QSsfbQ7EWyGm4ZGQkSxTdgWrB7RrZkpdcXQKOH2Ap+IUr5fqnj3JcyAN2qgmz6VrT2ek68QFw2YTj+RCBn0DcOf/GP4iDC2BFU20=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 197f06eb-bd9e-4bd5-1058-08d73d0a9dae
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 14:06:49.8920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: moIdWpUatUAdjlrk41VJ7PwVpfImd6aMNT8S/v6L2nNTj1e2Hs5tmI4wdlciIL+1lRtOUbcNxVOcSv7AXnbKtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5981
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiBPbiBUaHUsIDE5IFNlcCAyMDE5IGF0IDExOjQxLCBBdnJpIEFsdG1hbiA8QXZyaS5BbHRtYW5A
d2RjLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBVbGYvQWRyaWFuLA0KPiA+DQo+ID4gQXMgQ2hyaXMg
aXMgbGVzcyByZXNwb25zaXZlIGluIHRoZSBwYXN0IGZldyB5ZWFycywgV2UgbWlnaHQgd2FudCB0
bw0KPiA+IGZvbGxvdyB0aGUgc2NzaSBNTCBwcmFjdGljZSB3aXRoIHJlZ2FyZCB0byB0aGUgdWZz
IGRyaXZlcjoNCj4gPiBBZGQgc2V2ZXJhbCByZXZpZXdlcnMgd2hpbGUgTWFydGluIGlzIHB1bGxp
bmcgdGhlIHBhdGNoZXMuDQo+IA0KPiBUaGlzIGhhcyBiZWVuIGRpc2N1c3NlZCBlYXJsaWVyIFsx
XSBhbmQgQ2hyaXMgYWxzbyBhZ3JlZWQgdGhhdCBpdCBzZWVtcyBsaWtlIGENCj4gZ29vZCBpZGVh
Lg0KVGhlbiBJIHdvdWxkIGxpa2UgdG8gc3VnZ2VzdCBteXNlbGYgYXMgYSByZXZpZXdlciBbUl0u
DQpJIGhvcGUgdGhhdCBzb21lIG1vcmUgcGVvcGxlIHdvdWxkIGJlIGludGVyZXN0ZWQgdG8gc3Vw
cG9ydCB0aGlzLg0KV291bGQgeW91IGJlIGFibGUgdG8gcGljayBtbWMtdXRpbHMgcGF0Y2hlcz8N
Cg0KVGhhbmtzLA0KQXZyaQ0KDQo+IA0KPiA+DQo+ID4gSXQgaXMgd29ya2luZyBxdWl0ZSB3ZWxs
IHNpbmNlIHRoZW4uDQo+ID4NCj4gPiBJcyB0aGlzIHNvbWV0aGluZyB0aGF0IHlvdSBtaWdodCBj
b25zaWRlcj8NCj4gDQo+IEFzIHNhaWQsIGl0J3MgYmVlbiBkaXNjdXNzZWQuIEkgdGhpbmsgaXQg
Ym9pbHMgZG93biB0byB0aGF0IHNvbWVvbmUgbXVzdA0KPiB2b2x1bnRlZXIgdG8gaGVscCBDaHJp
cy4gVGhlbiBpdCdzIGp1c3QgYSBtYXR0ZXIgb2YgZm9ybWFsaXppbmcgdGhpcywgc2V0IHVwIGdp
dA0KPiBwdXNoIHBlcm1pc3Npb25zIGFuZCBkb2N1bWVudCB0aGUgbmV3IHdheXMgb2YgbWFpbnRl
bmFuY2UuDQo+IA0KPiBQZXJoYXBzIHlvdSB3b3VsZCBiZSBpbnRlcmVzdGVkIHRvIGhlbHAgb3V0
Pw0KPiANCj4gWy4uLl0NCj4gDQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQo+IA0KPiBbMV0NCj4g
aHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDcwOTU0My8NCg==
