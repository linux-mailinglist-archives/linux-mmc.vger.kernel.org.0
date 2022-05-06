Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864AA51D833
	for <lists+linux-mmc@lfdr.de>; Fri,  6 May 2022 14:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245378AbiEFMzO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 6 May 2022 08:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiEFMzN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 May 2022 08:55:13 -0400
X-Greylist: delayed 6736 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 May 2022 05:51:30 PDT
Received: from spf26.trabajo.gob.ec (spf26.trabajo.gob.ec [190.152.44.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595EC5AA72;
        Fri,  6 May 2022 05:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=trabajo.gob.ec; s=trabajo;
        h=Message-Id:Reply-To:Date:From:To:Subject:Content-Description:Content-Transfer-Encoding:MIME-Version:Content-Type; bh=1yRzq0DZsIZjcXwAKrsL0IEgLapFOXBvt5L3aNoafiE=;
        b=k6KaMpV4sOKO7BU4Om/5NxjqbnkXEjj05TCvo5dgyCpsv2g8/BK5DesFlqFl4vM7Ye+aH8WT/b7/f9qZP+qbc6vUbKXpOGtI7MwaghDkhIZGRHm2NmNM75q9FEyVZifW/vUMHISpWTYSeiHwAO22yKGhSwufwh9d5/8H29n4CX0=;
Received: from master4.trabajo.gob.ec ([192.168.198.154])
        by spf26.trabajo.gob.ec with esmtps (UNKNOWN:AES256-GCM-SHA384:256)
        (Exim 4.76)
        (envelope-from <karla_lascano@trabajo.gob.ec>)
        id 1nmvff-0003Nd-KY; Fri, 06 May 2022 05:58:53 -0500
Received: from master4.trabajo.gob.ec ([192.168.198.154] helo=localhost)
        by master4.trabajo.gob.ec with esmtp (Exim 4.76)
        (envelope-from <karla_lascano@trabajo.gob.ec>)
        id 1nmvfa-0002OS-Qg; Fri, 06 May 2022 05:58:47 -0500
X-Quarantine-ID: <v1FKzYw5wvjZ>
Received: from atmailing.trabajo.gob.ec ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (minspectord-new, port 10024)
        with ESMTP id v1FKzYw5wvjZ; Fri,  6 May 2022 05:58:46 -0500 (-05)
Received: from [192.168.1.127] (helo=webmail.trabajo.gob.ec)
        by atmailing.trabajo.gob.ec with smtp (Exim 4.76)
        (envelope-from <karla_lascano@trabajo.gob.ec>)
        id 1nmunL-0002NI-5m; Fri, 06 May 2022 05:02:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by webmail.trabajo.gob.ec (Postfix) with ESMTP id A6521E0D06;
        Fri,  6 May 2022 04:58:58 -0500 (ECT)
Received: from webmail.trabajo.gob.ec ([127.0.0.1])
        by localhost (webmail.trabajo.gob.ec [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id J_XGF2TuWzfB; Fri,  6 May 2022 04:58:58 -0500 (ECT)
Received: from webmail.trabajo.gob.ec (localhost [127.0.0.1])
        by webmail.trabajo.gob.ec (Postfix) with ESMTP id 02E3CE1261;
        Fri,  6 May 2022 04:57:33 -0500 (ECT)
Received: from [10.13.18.7] (unknown [156.146.63.14])
        by webmail.trabajo.gob.ec (Postfix) with ESMTPSA id 11E60E1BF7;
        Fri,  6 May 2022 04:56:44 -0500 (ECT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: OFFER
To:     Recipients <karla_lascano@trabajo.gob.ec>
From:   Susanne Klatten <karla_lascano@trabajo.gob.ec>
Date:   Fri, 06 May 2022 17:53:26 +0800
Reply-To: susanne.klatten212@gmail.com
Message-Id: <20220506095646.11E60E1BF7@webmail.trabajo.gob.ec>
X-RCPTControl: Supera
X-CantidadCopias: 610
X_SOURCE_IP: 192.168.1.127
X_SOURCE_IP: 192.168.1.127
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [susanne.klatten212[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello

I'm Susanne Klatten and I am  From Germany, I can control your financial pr=
oblems without resorting Banks in the range of Credit Money . We offer pers=
onal Loans and Business Loan, i am an approved and certified lender with ye=
ars of experience in Loan lending and we give out Collateral and Non Collat=
eral Loan amounts ranging from 10,000.00=E2=82=AC ( $)  to the maximum of 5=
00,000,000.00=E2=82=AC  with a fixed interest of 3% on an  annual basis. Do=
 you need a Loan?   Email us at:  susanne.klatten212@gmail.com

You can also view my link and learn more about me.

https://en.wikipedia.org/wiki/Susanne_Klatten
https://www.forbes.com/profile/susanne-klatten

Email :  susanne.klatten212@gmail.com
Signature,
Executive Chairman
Susanne Klatten.





