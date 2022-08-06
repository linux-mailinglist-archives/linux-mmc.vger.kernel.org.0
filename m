Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E75E58B3AA
	for <lists+linux-mmc@lfdr.de>; Sat,  6 Aug 2022 06:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbiHFEWY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-mmc@lfdr.de>); Sat, 6 Aug 2022 00:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiHFEWW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 6 Aug 2022 00:22:22 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 Aug 2022 21:22:20 PDT
Received: from lvs-smtpgate1.nz.fh-koeln.de (lvs-smtpgate1.nz.FH-Koeln.DE [139.6.1.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B091167E7
        for <linux-mmc@vger.kernel.org>; Fri,  5 Aug 2022 21:22:20 -0700 (PDT)
Message-Id: <178efe$25kfpq@smtp.intranet.fh-koeln.de>
X-IPAS-Result: =?us-ascii?q?A2D//wAI6+1iKtLeBosRCj8cAQEBKwsGAQEEBAEBAgEBB?=
 =?us-ascii?q?wEBFYFPAgEBGQgBgRYCAQEBAQEBSgEBAQGBE4EsAQErhE6DT4hPI4MgAYEpg?=
 =?us-ascii?q?nWLFoFjBQIBAYIpjFkLAQEBAQEBAQEBCRICJQkEAQGFBAFTAQEBAQeEHyY3B?=
 =?us-ascii?q?g4BAgQBAQEBAwIDAQEBAQEBAwEBCAEBAQEGBAcBAQEBAUhIhS85DV8BAQGBD?=
 =?us-ascii?q?DQBAQGEEAEBAQYBAQErayACGQ0CRQQWRwEBAQGCRkUBAQGCJQEBMxOCdJ86h?=
 =?us-ascii?q?2GBMYEBgimBJgGBC4IpBYJygRcqAgEBAQEBAQEBh2uQXIEPAQKFGB0TglIEm?=
 =?us-ascii?q?CkCAho4AzQRHjcLA10ICRcSIAIEERoLBgMWPgkCBA4DQAgNAxEEAw8YCRIIE?=
 =?us-ascii?q?AQGAzEMJQsDFAwBBgMGBQMBAxsDFAMFJAcDHA8jDQ0EHx0DAwUlAwICGwcCA?=
 =?us-ascii?q?gMCBhUGAgJOOQgECAQrJA8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFgIQCAIIJ?=
 =?us-ascii?q?xcHEzMZAQVZEAkhHAkfEAUGEwMgbwVFDygzNTwrHxsKYCcLKicEFQMEBAMCB?=
 =?us-ascii?q?hMDAyICEC4xAxUGKRMSLQkqdQkCAyJuAwMEKC4DCUAHCSYsPQUFRz4PlnmCE?=
 =?us-ascii?q?IE4AjCHC41Cg2UFilagWwcDg1GBRAKTfowogkaSdA4EkX0JhW+EdowSp1iBd?=
 =?us-ascii?q?4F/cIFuCSWBG1EZD5ISil90AjkCBgEKAQEDCYxlgQqBGAEB?=
IronPort-Data: A9a23:Bd3XaK27RYcpkfnD9/bD5UR2kn2cJEfYwER7XKvMYLTBsI5bpzBRx
 zAYC2CFbPmMZzCmfop2bty+9RxSsMOEzdZrHgJl3Hw8FHgiRegppDi6wuUcGwvIc6UvmWo+t
 512huHodZxyFDmEzvuUGuCJhWFm0q2VTabLBufBOyRgLSdpUy5JZShLwobVv6Yx6TSHK1LV0
 T/Ni5CHULOV82YcGn4Z7auFtCRusJza0N/PlgVjDRzjlAa2e0g9VPrzF4noR5fLatU88tqBe
 gr25OrRElU1X/saIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt9J1z
 ZJfkYDrdRxzHoGSxMFFQhh4Fi4raMWq+JefSZS+mem65BSbXSCq3e1oSk82eI4f9+JxR21Dn
 RAaAGlWP1bdwbjsmvThE7EEascLdaEHOKsas3pjwDfLDPtgXY3fX6HHzdRRmi0qwMtJGJ4yY
 uJGMmI1N06RO3WjPH82B64QvuuhlkXUTCVBqFikoq5s0UPMmVkZPL/FaoOOI4faFK25hH2wo
 2va/2X0H1cWOceZziuI6GmEnujLjCbnXMQZHdWQ9Plum1S73GEfCBQKE1C8pJGRhUfkBYoBd
 mQW/S41pO42/UbtQ9/yGReiuTiesxIcUsYWGOo/gCmXzbHI7gqFLmcDSTJEacdgs9U5LRQj1
 UeMt9foAyF/9bOSVHSR/6uVqjX0PjIaRUcIYmoATBYt497/pYgyilTESdMLOK28i9DnEC75h
 TCLti8vmp0RlYgFyqe64UvaxTmro/DhSwMxzg7MWCS46kV4aeaNbIiA7Vnd8OYFIoGESFWIo
 HkDnY6Z9u9mJYqRnSaJTc0OEauv6vLDNyfT6XZtGJQJ7zm38H6uZsZb5zQWDEhzO8gKPy7gZ
 kD7tgZY5ZsVN3yvBYdzbp6xAsACyanmCMSgTfCSacBBCrB+eRWI1DpobFaf0mn31kMrlMkXM
 5qdWd2tCGoXAuJsy3yrRI813bY1xyx7z0vLTJvxwhCjl7yTeBa9TbYDLUvLa+UyxL2LrR+T8
 NtFMcaOjRJFX4XWZyDR7IMXa1QDMGMgLZ/zos1TMOWEJ2JOHmAqDNfayLZnfJZq94xZjPXF4
 2qVVlVKxUfkw3bXQThmcVh7Mum1B88n62wjO2kgLFDu1XhmYoGi6KFZe5ZfkaQbGPJLz/pxC
 OshZ568Ga5vZmqb3mwMbLn4o9k3HPi0vj5iLxZJcRBmIcMxGVKUpYa4Fuf83HRWX3Dm6qPSt
 5X+h1+LEPLvUiw/VK7rhOSTI0SZkVV1dAhadEzMJdZVdS0AG6A3c3Ku0Jfbz+kqLg/fxnOg1
 weQDFInqPLRu4889NjA7Z1oTrtF8MMnQCK250GBsd6L2dDypwJPO7NoXueSZiz6X2jp4qikb
 ug956iibaxYxgoQ6NMlT+wDIUcCCz3H+OEyIuNMQy6jUrhXIuk8fRFqIOEQ5/0dl+4D0edIc
 h/WpoYBUVl2BC8VOARIf1N+PrXrOQA8ljTP8e8+IEjhrCFw5qGMUVhUMAKKhTBPRIaZw6t6q
 drNTPU+ulLXt/bfGpPb3ki4AUzdcydRO0jm37lDaLLWZv0DkwkdO8SMW3WmvvliqbxkayEXH
 9Ndv4Ka75w0+6YIWyFb+aTltQaFuakzhQ==
IronPort-HdrOrdr: A9a23:GP98aK4JjMTorIFR4gPXwN/XdLJyesId70hD6qi5ISY4TiX+ra
 2TdZUgviMc5wxwZJhNo7G90cq7K080nKQdibX5W43SPzUPfQCTXeRfBODZrAEIdReRygcn79
 YDT5RD
X-IronPort-Anti-Spam-Filtered: true
THK-HEADER: Antispam--identified_spam--outgoing_filter
Received: from p222210.vpn-dyn.fh-koeln.de (HELO MAC15F3.vpn.fh-koeln.de) ([139.6.222.210])
  by smtp.intranet.fh-koeln.de with ESMTP/TLS/DHE-RSA-AES128-SHA; 06 Aug 2022 06:21:13 +0200
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: Charity Donation
To:     You <mackenzie.tuttle@ca.rr.com>
From:   "MacKenzie Scott" <mackenzie.tuttle@ca.rr.com>
Date:   Sat, 06 Aug 2022 05:21:10 +0100
Reply-To: mackenzie-tuttle@californiamail.com
X-Priority: 1 (High)
Sensitivity: Company-Confidential
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_REPLYTO,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,
  My name is MacKenzie Scott Tuttle; I'm a philanthropist and founder of one of the largest private foundations in the world. I'm on a mission to give it all away as I believe in ‘giving while living.’ I always had the idea that never changed in my mind — that wealth should be used to help each other, which has made me decide to donate to you. Kindly acknowledge this message and I will get back to you with more details.

Visit the web page to know more about me: https://www.nytimes.com/2022/04/10/business/mackenzie-scott-charity.html

Regards,
MacKenzie Scott Tuttle.
