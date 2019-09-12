Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0140B15BE
	for <lists+linux-mmc@lfdr.de>; Thu, 12 Sep 2019 23:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfILVL7 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 12 Sep 2019 17:11:59 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:15503 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfILVL7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Sep 2019 17:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1568322717;
        s=strato-dkim-0002; d=heimpold.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=NskpMys5MvCadLiAwTRGYnFIfunysh0nn0zh6ShO5uk=;
        b=JuN0QpDyrRD8A4VMxwXSfB2/lWdwiFbMIe042yHzzo9jxWraYGfhwKJm3Lb4rlctBZ
        lKzLU5nZzzyMv3oAodfFGsN1TxfAbYv0YJFokYi0r/MC3em1ZotbY5Ko3+LaP8svitFV
        px/vKrdgTXXgMRNSf8wBznFLMLcOWAJ3qAyNLO7cLTXru1BFrM4BeLRMaFMcmdPKiq9W
        7MEcxW1CBsVr7LuwFi/1rVWZiwSmz0ZhytZaMkk1YHLqbPwx1Oc/JiDd/d9kj6ClrsUw
        vPntWdyhU7Vs0FNvb0AHz19JyEUnDXO8RaLk5M5i9YN2Q1QfHlbrg1B2O/1Jm4zO8U3Y
        G/iw==
X-RZG-AUTH: ":O2kGeEG7b/pS1EW8QnKjhhg/vO4pzqdNytq77N6ZKUSN7PfdWTGTOWHr182H3hxoqa1Ifw=="
X-RZG-CLASS-ID: mo00
Received: from tonne.mhei.heimpold.itr
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id 601202v8CL5ud5v
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 12 Sep 2019 23:05:56 +0200 (CEST)
Received: from kerker.mhei.heimpold.itr (kerker.mhei.heimpold.itr [192.168.8.1])
        by tonne.mhei.heimpold.itr (Postfix) with ESMTP id 4E0321407DF;
        Thu, 12 Sep 2019 23:05:55 +0200 (CEST)
From:   Michael Heimpold <mhei@heimpold.de>
To:     chris@printf.net
Cc:     linux-mmc@vger.kernel.org, Michael Heimpold <mhei@heimpold.de>
Subject: [PATCH mmc-utils v2 0/5] Various fixes for mmc-utils
Date:   Thu, 12 Sep 2019 23:05:04 +0200
Message-Id: <20190912210509.19816-1-mhei@heimpold.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This series bundles several small fixes and enhancements
I stumbled over during short testing around one year ago.

The initial sent v1 got a review by Avri, but was not applied (yet).

I'm resending this v2 with the hope, that there is now some
more interest.

I added his Reviewed-by, no other technical changes.

It can also be found in my Github tree:
https://github.com/mhei/mmc-utils/tree/fixes-enh

Michael Heimpold (5):
  Check calloc's return value before using the pointer
  Cleanup memory in error case
  Fix parsing of character in to_binstr()
  Optimize to_binstr() function
  Add eMMC vendor Micron to table

 lsmmc.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

-- 
2.17.1

