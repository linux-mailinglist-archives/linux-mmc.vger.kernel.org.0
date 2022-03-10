Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2699A4D3F3C
	for <lists+linux-mmc@lfdr.de>; Thu, 10 Mar 2022 03:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiCJCYK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 9 Mar 2022 21:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiCJCYJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Mar 2022 21:24:09 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E006543D
        for <linux-mmc@vger.kernel.org>; Wed,  9 Mar 2022 18:23:09 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id w7so7014185lfd.6
        for <linux-mmc@vger.kernel.org>; Wed, 09 Mar 2022 18:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=4SL1/qbkTptdsuZGoXAM80S4DBJva1Vt53CdfbCl4nw=;
        b=n49jEqgOOZlZAzTE6GkVI70/fP1JQiv+kLP3dmlLbLM9ZtAecLMD5DTvaBsEcxadRx
         LTWgXoU/PRuD4emeS3Z8kER86GOqlkGxbDbgWRrNEMbNCme86bnDL4ryGWufdxz4zYk/
         CELbNZFvIOqOKLE9S+ajacX3CkCdR8Ndvim7NfOC6caTay0clYdkiMcqF7g1lOV1ypSA
         o00kX/eCKUMC+ztjtXWOTjtYB214l/wHKer7JCGF5AikEn5ADE+3VWj9dCoqEEcpBPFK
         njjyE71TTLNgq+MSnJeo8fWya5HOdIl1jx/v84i57yCAIo6sDoymRqTJ6ZxL/sruR0EZ
         eprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=4SL1/qbkTptdsuZGoXAM80S4DBJva1Vt53CdfbCl4nw=;
        b=S4aLv6R66esJsVqMpzOsUIGv2hIdJtRgaxm6B+zHTQqa+PmCB+EvCKSzJ7A/maXjdN
         ztmC0sj1SgMtTLhE1CABuR6Cm94j+veEWadkqx74IcXIxrmQDW4d9xiymli6FK3Zbn99
         uK0otjC7a5xZ7+BuSkSfGc8fT7cnycAxu4fO9AVXk66I38SN/mTS2F/eYOzVVOaISTzU
         CjAxrxx3Dw3fU4skd/FgZxUSpOjMbsHFBUzYTSNNPipOd3nbHkjejD0DLuQlm8nDLwoj
         2Og2voax2RmbfvldTuwATtEJXssXMjwFRSJKR/LqvKL+L+mC3zIjsunCsp1463rz2q6V
         601g==
X-Gm-Message-State: AOAM533ym2QUTO7iknvijO+LbzKxj9Q/SaJWkF49RFWAj4RwvSt/TS/7
        HFhry21ye/DJa5JpW8NiH+X6wSv0JLiF6tV4Db8=
X-Google-Smtp-Source: ABdhPJw4ep+oKQcDE44OKgXzc49FwlYVy9xuYjp5PcgY1AtNH7uPMVSFipB8+J7k3+X/35Ewb87oKJnKBtuTLkkmsQQ=
X-Received: by 2002:a05:6512:3994:b0:448:3821:a416 with SMTP id
 j20-20020a056512399400b004483821a416mr1636186lfu.613.1646878987850; Wed, 09
 Mar 2022 18:23:07 -0800 (PST)
MIME-Version: 1.0
Sender: malindaandrew731@gmail.com
Received: by 2002:a05:6512:151f:0:0:0:0 with HTTP; Wed, 9 Mar 2022 18:23:07
 -0800 (PST)
From:   "Mrs. Latifa Rassim Mohamad" <rassimlatifa400@gmail.com>
Date:   Wed, 9 Mar 2022 18:23:07 -0800
X-Google-Sender-Auth: owOpQ6HerroDkMwvEjS5GFnAzjE
Message-ID: <CAFJdX88pp0ho-zs=-JZeNyonQOHNN34z=sRP5REN+Mm4gvOF0g@mail.gmail.com>
Subject: Hello my beloved.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_NAME_FM_MR_MRS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Greetings dears,

Hello my dear Good evening from here this evening, how are you doing
today? My name is Mrs.  Latifa Rassim Mohamad from Saudi Arabia, I
have something very important and serious i will like to discuss with
you privately, so i hope this is your private email?

Mrs. Latifa Rassim Mohamad.
