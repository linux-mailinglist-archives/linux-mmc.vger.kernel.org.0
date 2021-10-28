Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FE143E55F
	for <lists+linux-mmc@lfdr.de>; Thu, 28 Oct 2021 17:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhJ1Prm (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 28 Oct 2021 11:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhJ1Prm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Oct 2021 11:47:42 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEABC061745
        for <linux-mmc@vger.kernel.org>; Thu, 28 Oct 2021 08:45:15 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so9222902ott.2
        for <linux-mmc@vger.kernel.org>; Thu, 28 Oct 2021 08:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:cc;
        bh=AT2vVSkbs5Z2AlPH3lVSxISBm4g33VFLgVGD3BjUf+w=;
        b=YyJgDt1mEH4cO9L0C3eZ8WIzZkx77+uNkhgw/PckhjybYjvuvEF/e4Z9pSQZ3PvYxh
         xgRXI47nDvdk0hwf5o1y3VZe59gjTo7x2ldbZmIwaSQqDRsK/Q31tby7qRD4YmSpo+/W
         8JrV7HUbBueSRVJ4t/vLRF1kjYYP2sOK5ZQyLpsIf7ULUvK33CHsUL2ek/93tHmpcrNB
         j9iIO08R3Bnj+lcTX1d7yuF5QPqlNrx4mVfsabehpKLh6c6lmuNonMGu0W8eABm2OZ4M
         cNHuSlDbDNvbl7AUliHafBR+ZLXbFU/fNSktqW/xxdO92aSNXMYS5pSTX5P6ZbKtWLp9
         l4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:cc;
        bh=AT2vVSkbs5Z2AlPH3lVSxISBm4g33VFLgVGD3BjUf+w=;
        b=JhfphC0JBiCKBt9xeWdH2LwUr+XCrttFxcwcGVjdEy7BfZq79Xz+CR8MaW4mq2KGOK
         CFV3IhoMgA28ygXJl3cRgEQPPgn8yDkNPYrbCq4JGcl+207ga/EHw5xdKr3JL+wrtFDW
         U7UG83JKxSMjBS5Dc/vi9Gk5QF+JOw1G6tfxAw1OoDAbFjFSpJsVSblhTMBx0fjheFDw
         bOQ7P3AW61vw8GydoCMzuRnv7ZS8p05ZcSvuKBy8qou31G8Iz37MM1MeEHM9r9Fnc7mw
         uKFI7kzvxmSguEDHZzNUrnYZLen4xDQ7hrh0yg3dbAkTd2IGFEkFJaofksbN2bKc61VQ
         7orA==
X-Gm-Message-State: AOAM532yrEyPqlSr9rJrCPH7ptKPoXuEkdeoRwF7a++dfL9dQ4Z4uGoN
        UwHuVJRgN3eX3Ys9ktBuOW4xsW/6KbkmF0YdYwM=
X-Received: by 2002:a05:6830:10d1:: with SMTP id z17mt3487369oto.70.1635435914575;
 Thu, 28 Oct 2021 08:45:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:c04:0:0:0:0:0 with HTTP; Thu, 28 Oct 2021 08:45:14 -0700 (PDT)
Reply-To: israelbarney287@gmail.com
In-Reply-To: <CAA4TxLAyeSCDcVZFoRpW7rgJWnBBciXLvyeaxiGhUf+-11-BYw@mail.gmail.com>
References: <CAA4TxLAMbg3P_juOxMhMgRSf11ycHNowNK108Pgd=1tLLm-w+w@mail.gmail.com>
 <CAA4TxLCmxhnH0Hax3xtyboHQoDviKGMNZscHOn9f2F3atMsV_Q@mail.gmail.com>
 <CAA4TxLBdgbTi89SZqMnVjvd+xnKEnhj73r2vGghMo=kCHLTFOw@mail.gmail.com>
 <CAA4TxLBokA90f8YWm+XWCw9R_MapS2cHVn17RidhHEJn6YiXEg@mail.gmail.com>
 <CAA4TxLD=OOf8S05w2MdEb3BvQjw0nVqi5w4TABWVs8dA45TcvA@mail.gmail.com>
 <CAA4TxLDyitgj3tuuZd=yfy5irFunBGsiF8hAmKF4efiYQ7i2tQ@mail.gmail.com>
 <CAA4TxLCRNk8_OtCYq3Q8MB5jjqVtF3MMLZ+kp6JJ8AcXhFX_QQ@mail.gmail.com>
 <CAA4TxLBE3ag+PsMzf_jJZMJbJ+0hhBsJhm=kADmqCx-sAiMcJQ@mail.gmail.com>
 <CAA4TxLBn_13xcFsHb0Dj87RTqzc7dJMxOfYM6E=S8YPRRxpUmw@mail.gmail.com>
 <CAA4TxLAdOsBq+wuJu9RJYj+XQUJU=xRWAihFPLfUfMxF5WVpmw@mail.gmail.com>
 <CAA4TxLBPa5TkbFXy_DkC+AuMjmU+Mn3K-kYF=6rn9ecLXpvmGA@mail.gmail.com>
 <CAA4TxLDPg22VA+-wBbFgb9pFoYnomDP5X2qLLCXOpv-cN0HXFg@mail.gmail.com>
 <CAA4TxLDpqABNMK175BcVtuSJ+tdW0gxr=NK3VNutfjYTvj1EFg@mail.gmail.com>
 <CAA4TxLAY9PJrz3G16EoM3UkpiXMP08+PAubtukhA8Zt4FEyRRA@mail.gmail.com>
 <CAA4TxLDM6fDFRxMD7fMGk8ntyhuewotY3+o2AhDBQpDZT=3sJw@mail.gmail.com>
 <CAA4TxLDw7_BQ_VLkpXQcgOkgGPV4k+4RrrPoSwELNBeYO9cqKg@mail.gmail.com>
 <CAA4TxLA6a2eWHj2mAfw+Ucucw=FC7CguD8kyXCLh6MePKvSpVw@mail.gmail.com>
 <CAA4TxLDcpo7N-7wM1ZMWpLt8O-nVq7p=U_BXuCFfYaLJe21Dkw@mail.gmail.com>
 <CAA4TxLBS8Y1_RTBt+yUOi5m7QAkJaNCA4m-D33qcgLjsza5=hw@mail.gmail.com>
 <CAA4TxLDS=N7dtE3K2YBkiAeyYTRsKw841xQHgnLitd=6KVz30w@mail.gmail.com>
 <CAA4TxLAb0cuZq6ymVXs-+K9xU-t6zMqYCSjahaUo2ROrhQ1SjQ@mail.gmail.com> <CAA4TxLAyeSCDcVZFoRpW7rgJWnBBciXLvyeaxiGhUf+-11-BYw@mail.gmail.com>
From:   israel barney <kristengriest098@gmail.com>
Date:   Thu, 28 Oct 2021 16:45:14 +0100
Message-ID: <CAA4TxLBHsZu3FneDQna2kqetvYCGqaJaJWEe0ge+gqb6d0hhZw@mail.gmail.com>
Subject: Greetings
Cc:     israelbarney287@gmail.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

do you receive my massage
