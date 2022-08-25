Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04E35A0EBA
	for <lists+linux-mmc@lfdr.de>; Thu, 25 Aug 2022 13:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbiHYLJQ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 25 Aug 2022 07:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241358AbiHYLJO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Aug 2022 07:09:14 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57139AE9C8
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2022 04:09:14 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-f2a4c51c45so24419591fac.9
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2022 04:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=NcQgfGWmNtGVcmYOkqhvmNWuEth66CXwSKmPdJfqqgM=;
        b=CHBqK1QKe85QYSj4xZvDZ4U7ZfP0wWmG4+32RqVkNdpnrPDePcZos3nRtZU5m6tMcb
         X5CdeI/wRo5IsrNHPMbF41vR/KyS/aWwZYL/zb/MaY7jGWpgLiS3MNL8om685vAKmPJ+
         vM7QofTvxm/r0VPhXV1A5Sdu9MbUsR7kJ5tTROmSilM9/zAWnK2AbO5NUJcf4TYN5Z/u
         DE1sVqjUrfinexy6lA05mi/XQXZ19ipHxhTuXvU/NRlg4ZLVfsXURMi38yHc9Nu/poDI
         nAnfqiGH8w/80y6RlkYNtN/jIp4Y0xzdSdkLpKuYn9hNDp70qDy0VpxFZsyAYs0qMh3d
         I1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=NcQgfGWmNtGVcmYOkqhvmNWuEth66CXwSKmPdJfqqgM=;
        b=PkaSL6WmhzSmVyQbBcQg/PTs5Evou4zfPybwFDZVfKiy5J5EDNCVK5kJbZIiD4kKhq
         mhUJgeRaH65HRUCjLm/d7pfKxta/3MUtl82q3zh9HYl37d58KOoKfT4nuK2P8IGP7bVE
         DsEhW9Bq4DOSvtSnvvOqwFPzWU03csliZLqTtYS7aiIOYEY+GBYm3luw7vkwPc36FA5A
         gNZukdTnQADW5qTSjGitEtqsn/Pp/ro0TZAaPJKfJ/uKHJBTY/1P3UF4kemfGyAex95r
         x8X4ZM6WDdGcS17rt9rHEbShobxk4T5pqii5pT//uRLfbBQj7nv/qDEXJ9URwDJ4CC4t
         m8ng==
X-Gm-Message-State: ACgBeo06NlbeCk08B9LooRrTqOfB/yFmMrqmje+7qBFVfWg8sPYaIOhx
        cpKcMBbGPw2TIDHxJn10d7Ru87L4Yr2U6ncgY2s=
X-Google-Smtp-Source: AA6agR7mqiIqn4i/xzOZQg0uzufoHF13EjbWV08N3lIdQCYMI61hajWbgVQyDXW2zCtX+ls6zlACD+66qCKGRME9fA8=
X-Received: by 2002:a05:6870:b51f:b0:11e:39c8:cc10 with SMTP id
 v31-20020a056870b51f00b0011e39c8cc10mr361745oap.184.1661425753602; Thu, 25
 Aug 2022 04:09:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5ec3:0:0:0:0:0 with HTTP; Thu, 25 Aug 2022 04:09:13
 -0700 (PDT)
Reply-To: sgtkaylla202@gmail.com
From:   kayla manthey <tadjokes@gmail.com>
Date:   Thu, 25 Aug 2022 11:09:13 +0000
Message-ID: <CAHi6=KZU3u5Nfw6vBcaGxxGz+Vj48Y-E8BDa7od_+nLUGF20Tg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:2d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tadjokes[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sgtkaylla202[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Bok draga, mogu li razgovarati s tobom, molim te?
